class Video < ActiveRecord::Base
  after_create :check_language
  has_many :usefull_links, dependent: :destroy , inverse_of: :video
  has_one :snippet, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :video_tags, dependent: :destroy
  has_many :tags, through: :video_tags
  belongs_to :user
  
  validates :title, :file_link, :description, :image, presence: true
  validates :duration, numericality: { only_integer: true }
  mount_uploader :image, ImageUploader

  translates :title, :description
  
  accepts_nested_attributes_for :usefull_links, allow_destroy: true
  accepts_nested_attributes_for :snippet, allow_destroy: true

  scope :order_video, ->{
    order("created_at DESC")
  }

  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    # where("title like ?", "%#{query}%") 
    # Video.find_by_title "%#{query}%"
    with_translations.where("video_translations.title LIKE ?", "%#{query}%")
  end

  def simlar_videos
    if tags.any?
      tags.order("RAND()").first.videos.order("RAND()").limit(4)
    else
      Video.order("RAND()").limit(4)
    end
  end

  def check_language
    unless I18n.locale == :en
    end
  end
end
