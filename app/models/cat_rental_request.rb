class CatRentalRequest < ActiveRecord::Base
  validates :start_date, :end_date, :cat_id, :status, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED),
    message: "%{value} is not a valid status" }
  validate :not_overlapping_request
  after_initialize{ self.status ||= "PENDING" }

  belongs_to :cat

  def overlapping_requests
    " AND cat_id = ?
      AND ((start_date BETWEEN ? AND ?) OR (end_date BETWEEN ? AND ?))
      AND id != ?"
  end

  def values
    [self.cat_id, self.start_date, self.end_date,
    self.start_date, self.end_date, self.id]
  end

  def overlapping_pending_requests
    CatRentalRequest.all
      .where("status = 'PENDING' #{overlapping_requests}", *values)
  end

  def overlapping_approved_requests
    CatRentalRequest.all
      .where("status = 'APPROVED' #{overlapping_requests}", *values)
  end

  def approve!
    CatRentalRequest.transaction do
      self.status = 'APPROVED'
      self.save!
      overlapping_pending_requests.each do |request|
        request.deny!
      end
    end
  end

  def deny!
    self.status = 'DENIED'
    self.save!
  end

  private
  def not_overlapping_request
    return true if self.status == 'DENIED'
    if overlapping_approved_requests.any?
      errors[:base] << "Overlapping request dates"
    end
  end

end
