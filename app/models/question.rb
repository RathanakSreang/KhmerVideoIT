class Question < ActiveRecord::Base
  belongs_to :user
  has_many :question_tags, dependent: :destroy
  has_many :tags, through: :question_tags
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, :content, presence: true

  def self.search(query)    
    where("content like ?", "%#{query}%") 
  end
end
