class Hospital < ApplicationRecord
  validates :name, :address, presence: true
end
