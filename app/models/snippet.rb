class Snippet < ActiveRecord::Base
  belongs_to :video

  validates :content, presence: true
end
