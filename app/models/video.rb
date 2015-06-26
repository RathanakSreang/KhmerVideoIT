class Video < ActiveRecord::Base
  belongs_to :tutorial
  has_many :usefull_links, dependent: :destroy , inverse_of: :video
  has_one :snippet, dependent: :destroy
  
  
  validates :title, :description, :image, presence: true
  mount_uploader :image, ImageUploader

  accepts_nested_attributes_for :usefull_links, allow_destroy: true
  accepts_nested_attributes_for :snippet, allow_destroy: true

  scope :order_video, ->{
    order("created_at DESC")
  }

  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("title like ?", "%#{query}%") 
  end
end
