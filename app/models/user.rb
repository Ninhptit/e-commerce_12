class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  before_create :create_activation_digest
  enum role: {banned: 0, member: 1, admin: 2}
  enum provider: {local: 0, facebook: 1, google_oauth2: 2}

  has_many :ratings
  has_many :orders
  has_many :comments
  has_many :products, dependent: :destroy
  has_many :categories, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true, length: {maximum:
    Settings.user.name.maximum}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.user.email.maximum},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false, scope: :provider}
  has_secure_password
  validates :password, presence: true,
    length: {minimum: Settings.user.password.minimum}, allow_nil: true
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest string
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create string, cost: cost
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def activate
    update_attribute :verified, true
    update_attribute :activated_at, Time.zone.now
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def forget
    update_attribute :remember_digest, nil
  end

  def create_reset_digest
    self.reset_token = User.new_token
    digest = User.digest reset_token
    update_columns reset_digest: digest, reset_send_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_send_at < Settings.time.hours.ago
  end

  def self.from_omniauth auth
    where(provider: auth.provider, uid: auth.uid)
      .first_or_initialize.tap do |user|
      user.create_user_omiauth auth
      user.save!
    end
  end

  def create_user_omiauth auth
    self.provider = auth.provider
    self.uid = auth.uid
    self.name = auth.info.name
    self.email = auth.info.email
    self.remote_avatar_url = auth.info.image.gsub("http://", "https://")
    self.password = random_password
    self.oauth_token = auth.credentials.token
    self.oauth_expires_at = Time.at(auth.credentials.expires_at)
  end

  private
  def random_password
    (0...10).map{("a".."z").to_a[rand(26)]}.join
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest activation_token
  end

  def picture_size
    errors.add(:avatar, t("should_be")) if avatar.size >
                                           Settings.picture.size.megabytes
  end
end
