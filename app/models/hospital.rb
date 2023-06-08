class Hospital < ApplicationRecord
  has_many :appointments
  has_many :coverages

  validates :name, :address, presence: true
end
