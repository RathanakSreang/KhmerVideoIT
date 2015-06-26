class Article < ActiveRecord::Base
  belongs_to :language

  validates :title, :content, presence: true
  
  scope :order_article, ->{
    order("created_at DESC")
  }
  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("title like ?", "%#{query}%") 
  end
end
