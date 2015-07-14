class Tag < ActiveRecord::Base
  extend FriendlyId
  
  # after_create :check_language
  has_many :video_tags, dependent: :destroy
  has_many :article_tags, dependent: :destroy
  has_many :question_tags, dependent: :destroy
  has_many :videos, through: :video_tags
  has_many :articles, through: :article_tags
  has_many :questions, through: :question_tags
  belongs_to :user

  validates :name, presence: true

  friendly_id :name, use: :slugged
  translates :name

  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    # where("name like ?", "%#{query}%")
    with_translations.where("tag_translations.name LIKE ?", "%#{query}%")
  end
  
  # def check_language
  #   unless I18n.locale == :en
  #     self.with_translations("en").name = name
  #     self.save
  #   end
  # end
end
