class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :hospital

  COLOR_PROTOCOLS = ["Azul", "Verde", "Amarelo"]

  validates :description, :color_protocol, :position, presence: true
end
