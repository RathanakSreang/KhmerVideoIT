class UsefullLink < ActiveRecord::Base
  belongs_to :video

  validates :title, :link, presence: true
end
