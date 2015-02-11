class User < ActiveRecord::Base
  validates :user_name, :password_digest, :session_token, :presence => true
  validates :password , length: { minimum: 6, allow_nil: true }
  validates :user_name, :session_token, uniqueness: true
  after_initialize :ensure_session_token

  has_many :cats


  attr_accessor :password
  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    return nil unless user
    user.is_password?(password) ? user : nil
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end


end
