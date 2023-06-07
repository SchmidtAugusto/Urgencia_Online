class Coverage < ApplicationRecord
  belongs_to :insurance_plan
  belongs_to :hospital

  validates :insurance_plan, uniqueness: { scope: :hospital }
end
