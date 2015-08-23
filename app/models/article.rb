class Article < ActiveRecord::Base
  extend FriendlyId
  # enum status: [:show, :hide]
  before_save :default_values
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags
  
  validates :title, :content, presence: true
  
  friendly_id :title, use: :slugged
  translates :title, :content, :description

  scope :order_article, ->{
    order("created_at DESC")
  }

  searchable do
    text :title, boost: 5
    text :content, :description
    boolean :status
    time    :publish_date
    text :user do
      user.name
    end
    text :tags do
      tags.map { |tag| tag.name }
    end
  end

  def self.status_show
    where status: true
  end

  def simlar_articles
    if tags.any?
      tags.order("RAND()").first.articles.order("RAND()").limit(4)
    else
      Article.order("RAND()").limit(4)
    end
  end

  def default_values
    self.status ||= :show
    self.publish_date ||= Date.current
  end

  def self.cached_latest_article
    Rails.cache.fetch([self, "latest_article"]){status_show.order("created_at DESC")
                    .includes(:translations).limit(6).to_a}
  end
end
