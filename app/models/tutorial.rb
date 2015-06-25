class Tutorial < ActiveRecord::Base
  belongs_to :language
  has_many :videos, dependent: :destroy

  validates :title, presence: true
end
