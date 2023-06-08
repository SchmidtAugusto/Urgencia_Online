class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :hospital

  COLOR_PROTOCOLS = ["Azul - não apresenta risco", "Verde - gravidade baixa", "Amarelo - gravidade moderada", "Laranja - grave", "Vermelho - gravíssimos ou risco de morte"]

  validates :description, :color_protocol, :position, presence: true
end
