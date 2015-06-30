class Article < ActiveRecord::Base  
  has_many :comments, as: :commentable, dependent: :destroy
  
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags
  
  validates :title, :content, presence: true
  

  scope :order_article, ->{
    order("created_at DESC")
  }
  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("title like ?", "%#{query}%") 
  end
end
