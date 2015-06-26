class Language < ActiveRecord::Base
  has_many :tutorials, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :videos, through: :tutorials
  validates :name, presence: true
  scope :order_language, ->{
    order("created_at DESC")
  }
end
