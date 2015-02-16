class Goal < ActiveRecord::Base
  validates :body, :user, presence: true

  belongs_to :user, inverse_of: :goals

  after_initialize { self.completed ||= false }

  def completed?
    self.completed
  end


end
