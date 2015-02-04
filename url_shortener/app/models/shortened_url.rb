class ShortenedUrl < ActiveRecord::Base

  validate :short_url, presence: true, uniqueness: true
  validate :long_url, presence: true, uniqueness: true
  validate :user_id, presence: true

  def self.random_code

    short_url = SecureRandom.urlsafe_base64

    while ShortenedUrl.exists?(:short_url => short_url)
      short_url = SecureRandom.urlsafe_base64
    end

    short_url

  end

  def self.create_for_user_and_long_url!(user, long_url)

    ShortenedUrl.create!(user_id: user.id, long_url: long_url, short_url: random_code)

  end

  belongs_to(
    :user,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id
  )


end
