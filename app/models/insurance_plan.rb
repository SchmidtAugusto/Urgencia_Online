class InsurancePlan < ApplicationRecord
  belongs_to :user

  validates :name, :plan, presence: true
  validates :product, :id_code, uniqueness: true
  validates :cns, presence: true, uniqueness: true
end
