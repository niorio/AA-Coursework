class Visit < ActiveRecord::Base

  validate :short_url, :user_id, :presence => true

  def self.record_visit!(user, shortened_url)
    Visit.create!(user_id: user.id, short_url: shortened_url.short_url)
  end

  belongs_to(
    :visitor,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  belongs_to(
    :shortened_url,
    :class_name => "ShortenedUrl",
    :foreign_key => :short_url,
    :primary_key => :short_url
  )


end
