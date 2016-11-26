class User < ActiveRecord::Base
  extend FriendlyId

  enum role: [:normal, :admin, :super]
  before_save :default_values

  has_many :comments, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :activities
  has_many :notice_activities, class_name: "Activity",
            foreign_key: "user_tracked_id"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :confirmable, :omniauthable
  validates :name, :email, presence: true, if: :provider?
  friendly_id :name, use: :slugged

  validates_uniqueness_of :email
  validates_length_of :password, minimum: 8, allow_blank: true, if: :provider?
  validates_confirmation_of :password,
                            message: "the password confirmation belove did not match", if: :provider?

  mount_uploader :avatar, AvatarUploader

  def self.all_admin
    where("role = 1 OR role = 2")
  end

  def default_values
    self.role ||= :normal
  end

  def self.from_omniath auth
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name

      if auth.provider == "twitter"
        user.url = auth.info.urls.Twitter
        user.email = "#{auth.uid}.twitter@twitter.com"#auth.info.email
      elsif auth.provider == "facebook"
        user.email = auth.info.email
        user.url = auth.info.urls.Facebook
      elsif auth.provider == "github"
        user.email = auth.info.email
        user.url = auth.info.urls.GitHub
      else
        user.email = auth.info.email
        user.url = auth.extra.raw_info.profile
      end
      user.skip_confirmation!
      user.save
    end
  end

  def provider?
    provider.blank?
  end

  def password_required?
    super && provider.blank?
  end

  def email_required?
    super && provider.blank?
  end

  def notify
    notice_activities.unread_activity(id)
  end

  def all_notify
    notice_activities.all_activity(id)
  end

  def finish_read_notify
    notify.each do |notice|
      notice.read = true
      notice.save
    end
  end
end
