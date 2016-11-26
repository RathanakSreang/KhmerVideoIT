class Page < ActiveRecord::Base
  validates :content, :title, presence: true
  validates :title, uniqueness: true
end
