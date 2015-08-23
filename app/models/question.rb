class Question < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user
  has_many :question_tags, dependent: :destroy
  has_many :tags, through: :question_tags
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, :content, presence: true
  friendly_id :title, use: :slugged

  searchable do
    text :title, boost: 5
    text :content
    time    :created_at
    text :user do
      user.name
    end
    text :tags do
      tags.map { |tag| tag.name }
    end
  end

  def simlar_questions
    if tags.any?
      tags.order("RAND()").first.questions.order("RAND()").limit(4)
    else
      Question.order("RAND()").limit(4)
    end
  end

  def self.cached_latest_question
    Rails.cache.fetch([self, "random_tags"]){order("created_at DESC")
                    .limit(6).to_a}
  end
end
