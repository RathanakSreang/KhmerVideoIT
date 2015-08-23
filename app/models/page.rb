class Page < ActiveRecord::Base
  validates :about, presence: true
  translates :about
  def self.cached_first
    Rails.cache.fetch([self, "first"]){first.to_a}
  end
end
