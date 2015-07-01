class Video < ActiveRecord::Base  
  has_many :usefull_links, dependent: :destroy , inverse_of: :video
  has_one :snippet, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :video_tags, dependent: :destroy
  has_many :tags, through: :video_tags
  
  validates :title, :file_link, :description, :image, presence: true
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

  def simlar_videos
    tags.order("RAND()").first.videos.order("RAND()").limit(4)
  end
end
