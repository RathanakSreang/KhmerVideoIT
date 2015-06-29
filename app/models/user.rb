class User < ActiveRecord::Base
  enum role: [:normal, :admin]
  before_save :default_values
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :confirmable
  validates :name, presence: true
  def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("email like ?", "%#{query}%") 
  end

  def default_values
    self.role ||= :normal
  end
end
