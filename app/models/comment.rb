class Comment < ActiveRecord::Base
  has_ancestry
  belongs_to :commentable, polymorphic: true, counter_cache: true
  belongs_to :user

  validates :content, presence: true

  searchable do
    text :content
    time :created_at
    text :user do
      user.name
    end
  end
end
