class Video < ActiveRecord::Base
  validates :title, :description, presence: true
end
