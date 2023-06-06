class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :birthdate, :address, presence: true
  validates :email, presence: true, uniqueness: true
  validates :cpf, presence: true, uniqueness: true, length: { is: 11 }
end
