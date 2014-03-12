require 'bcrypt'

class User
  include Mongoid::Document
  include Mongoid::Timestamps

  PASSWORD_RESET_EXPIRES = 1.day

  attr_accessor :password, :password_confirmation

  before_save :set_random_password, :encrypt_password

  field :email, type: String
  field :salt, type: String
  field :fish, type: String

  field :code, type: String
  field :expires_at, type: Time

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, confirmation: true

  def self.find_by_code(code)
    if user = User.find_by( :code => code, :expires_at.gte => Time.now.gmtime )
      user.set_expiration
    end
    user
  end

  def authenticate(password)
    self.fish == BCrypt::Engine.hash_secret(password, self.salt)
  end

  def self.authenticate(email, password)
    user = User.find_by email: email
    user if user and user.authenticate(password)
  end

  def set_password_reset
    self.code = SecureRandom.urlsafe_base64
    set_expiration
  end

  def set_expiration
    self.expires_at = PASSWORD_RESET_EXPIRES.from_now
    self.save
  end

  protected

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.fish = BCrypt::Engine.hash_secret(password, self.salt)
    end
  end

  def set_random_password
    if password.blank? and self.fish.blank?
      self.salt = BCrypt::Engine.generate_salt
      self.fish = BCrypt::Engine.hash_secret(SecureRandom.base64(32), self.salt)
    end
  end
end
