class InsurancePlan < ApplicationRecord
  has_many :plan_details
  has_many :coverages

  validates :name, presence: true
end
