class User < ActiveRecord::Base
  include Commentable

  validates :username, :session_token, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}

  after_initialize :ensure_session_token
  attr_reader :password

  has_many :goals
  has_many(
    :authored_comments,
    class_name: 'Comment',
    foreign_key: :author_id,
    primary_key: :id,
    inverse_of: :author
  )

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def public_goals
    self.goals.where(public: true)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

end
