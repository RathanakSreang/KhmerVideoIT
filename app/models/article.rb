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

  scope :order_article, ->{
    order("created_at DESC")
  }

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
end
