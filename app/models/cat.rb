class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, presence: true
  validates :sex, inclusion: { in: ["M","F"], message: "sex must be M or F" }
  validates :color, inclusion: { in: %w(black white brown gold),
                                message: "%{value} is not a valid color"}

  def age
    Time.now.year - birth_date.year
  end

end
