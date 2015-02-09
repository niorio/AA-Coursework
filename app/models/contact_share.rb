class ContactShare < ActiveRecord::Base
  validates :user_id, :contact_id, presence: true

  belongs_to :user, dependent: :destroy
  belongs_to :contact

end
