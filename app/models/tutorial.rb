class Tutorial < ActiveRecord::Base
  belongs_to :language
  has_many :videos, dependent: :destroy

  validates :title, presence: true

  scope :order_tutorial, ->{
    order("created_at DESC")
  }

  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("title like ?", "%#{query}%") 
  end
end
