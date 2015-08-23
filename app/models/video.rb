class Video < ActiveRecord::Base
  extend FriendlyId
  # enum status: [:show, :hide]
  before_save :default_values  
  has_one :snippet, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :video_tags, dependent: :destroy
  has_many :tags, through: :video_tags
  belongs_to :user
  
  URL_FORMATS = {
      regular: /^(https?:\/\/)?(www\.)?youtube.com\/watch\?(.*\&)?v=(?<id>[^&]+)/,
      shortened: /^(https?:\/\/)?(www\.)?youtu.be\/(?<id>[^&]+)/,
      embed: /^(https?:\/\/)?(www\.)?youtube.com\/embed\/(?<id>[^&]+)/,
      embed_as3: /^(https?:\/\/)?(www\.)?youtube.com\/v\/(?<id>[^?]+)/,
      chromeless_as3: /^(https?:\/\/)?(www\.)?youtube.com\/apiplayer\?video_id=(?<id>[^&]+)/
  }

  INVALID_CHARS = /[^a-zA-Z0-9\:\/\?\=\&\$\-\_\.\+\!\*\'\(\)\,]/
  # YT_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i
  YT_LINK_FORMAT = /\A(?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?([\w-]{10,})/
  validates :file_link, presence: true, format: YT_LINK_FORMAT
  validates :title, :description, presence: true
  validates :duration, numericality: { only_integer: true, greater_than: 0 }
  mount_uploader :image, ImageUploader

  translates :title, :description
  friendly_id :title, use: :slugged  
  accepts_nested_attributes_for :snippet, allow_destroy: true  

  scope :order_video, ->{
    order("created_at DESC")
  }

  searchable do
    text :title, boost: 5
    text :description
    boolean :status
    time    :publish_date
    text :snippet do
      snippet.content
    end
    text :user do
      user.name
    end
    text :tags do
      tags.map { |tag| tag.name }
    end
  end

  def self.status_show
    where status: true
  end

  def simlar_videos
    if tags.any?
      tags.order("RAND()").first.videos.order("RAND()").limit(4)
    else
      Video.order("RAND()").limit(4)
    end
  end

  def has_invalid_chars?(youtube_url)
    !INVALID_CHARS.match(youtube_url).nil?
  end

  def extract_video_id
    return nil if has_invalid_chars?(file_link)

    URL_FORMATS.values.each do |format_regex|
      match = format_regex.match(file_link)
      return match[:id] if match
    end
  end

  def default_values
    self.status ||= :show
    self.publish_date ||= Date.current
  end  
end
