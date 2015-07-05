class Page < ActiveRecord::Base
  validates :about, presence: true
  translates :about
end
