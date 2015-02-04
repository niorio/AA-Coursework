class User < ActiveRecord::Base

  validate :email, :presence => true, :uniqueness => true

  has_many(
    :submitted_urls,
    :class_name => "ShortenedUrl",
    :foreign_key => :user_id,
    :primary_key => :id
  )

end
