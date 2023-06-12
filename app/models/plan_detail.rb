class PlanDetail < ApplicationRecord
  belongs_to :user
  belongs_to :insurance_plan
end
