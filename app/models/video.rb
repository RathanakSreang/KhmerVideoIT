class Video < ActiveRecord::Base
  has_many :usefull_links, dependent: :destroy , inverse_of: :video
  has_one :article, dependent: :destroy
  
  
  validates :title, :description, :image, presence: true
  mount_uploader :image, ImageUploader

  accepts_nested_attributes_for :usefull_links, allow_destroy: true
  accepts_nested_attributes_for :article, allow_destroy: true
end
