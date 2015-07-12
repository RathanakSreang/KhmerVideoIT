class Question < ActiveRecord::Base
  belongs_to :user
  has_many :question_tags, dependent: :destroy
  has_many :tags, through: :question_tags
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, :content, presence: true

  def self.search(query)    
    where("content like ?", "%#{query}%") 
  end

  def simlar_questions
    if tags.any?
      tags.order("RAND()").first.questions.order("RAND()").limit(4)
    else
      Question.order("RAND()").limit(4)
    end
  end
end