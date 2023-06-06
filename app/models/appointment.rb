class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :hospital

  validates :description, :color_protocol, :position, presence: true
end
