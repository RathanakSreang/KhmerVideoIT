class Language < ActiveRecord::Base
  has_many :tutorials, dependent: :destroy
  
  validates :name, presence: true
end
