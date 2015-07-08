class Tag < ActiveRecord::Base
  has_many :video_tags, dependent: :destroy
  has_many :article_tags, dependent: :destroy
  has_many :question_tags, dependent: :destroy
  has_many :videos, through: :video_tags
  has_many :articles, through: :article_tags
  has_many :questions, through: :question_tags

  validates :name, presence: true

  translates :name

  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("name like ?", "%#{query}%") 
  end
  
end
