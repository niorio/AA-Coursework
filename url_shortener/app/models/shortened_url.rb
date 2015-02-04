class ShortenedURL

  validate :short_url, presence: true, uniqueness: true
  validate :long_url, presence: true, uniqueness: true
  validate :user_id, presence: true



end
