class Coverage < ApplicationRecord
  belongs_to :insurance_plan
  belongs_to :hospital
end
