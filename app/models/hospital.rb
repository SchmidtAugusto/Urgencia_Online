class Hospital < ApplicationRecord
  has_many :appointments
  has_many :coverages
  has_one_attached :photo

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :name, :address, presence: true
end
