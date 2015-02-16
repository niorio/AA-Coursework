class Goal < ActiveRecord::Base
  validates :body, :user_id, :public, presence: true

  belongs_to :user


end
