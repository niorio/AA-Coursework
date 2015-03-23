class User < ActiveRecord::Base
  validates :user_name, :password_digest, :presence => true
  validates :password , length: { minimum: 6, allow_nil: true }
  validates :user_name, uniqueness: true


  has_many :cats
  has_many :cat_rental_requests
  has_many :session_tokens

  attr_accessor :password
  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def create_session_token
    token = self.class.generate_session_token
    session_tokens.create!(session_token: token)
    token
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

  # private
  # def ensure_session_token
  #   session_tokens.any? || create_session_token
  # end


end
