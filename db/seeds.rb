# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "faker"

puts "Destroying all previous instances..."

Appointment.destroy_all
Coverage.destroy_all
InsurancePlan.destroy_all
MedicalRecord.destroy_all
User.destroy_all
Hospital.destroy_all

puts "All previous instances destroyed!"

puts "Creating hospitals..."
10.times do
  Hospital.create!(
    name: Faker::Company.name,
    address: Faker::Address.full_address
  )
end

puts "Hospitals created!"

puts "Creating users..."

def create_medical_records(user)
  MedicalRecord.create!(
    user: user,
    blood_type: Faker::Blood.type,
    height: Faker::Number.decimal(l_digits: 2),
    weight: Faker::Number.decimal(l_digits: 2),
    allergies: Faker::Lorem.sentence(word_count: rand(0..3)),
    health_conditions: Faker::Lorem.sentence(word_count: rand(0..6))
  )
end

position = 1

10.times do
  User.create!(
    email: Faker::Internet.email,
    password: "123123",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: Faker::Address.full_address,
    cpf: Faker::Number.number(digits: 11),
    birthdate: Faker::Date.birthday(min_age: 18)
  )
  create_medical_records(User.last)

  Appointment.create!(
    user: User.last,
    hospital: Hospital.all.sample,
    description: Faker::Lorem.sentence(word_count: rand(3..10)),
    color_protocol: Appointment::COLOR_PROTOCOLS.sample,
    position: position
  )
  position += 1
end

User.create(
  email: "admin@admin",
  password: "123123",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  address: Faker::Address.full_address,
  cpf: Faker::IDNumber.brazilian_citizen_number,
  birthdate: Faker::Date.birthday(min_age: 18),
  admin: true
)
create_medical_records(User.last)

puts "Users created!"

puts "Creating insurance plans..."

5.times do
  InsurancePlan.create!(
    name: Faker::Company.name,
    product: rand(100..999),
    id_code: Faker::Number.number(digits: 6),
    plan: Faker::Company.buzzword,
    cns: Faker::Number.number(digits: 15),
    user: User.all.sample
  )
end

puts "Insurance plans created!"

puts "Creating coverages..."

20.times do
  Coverage.create(
    insurance_plan: InsurancePlan.all.sample,
    hospital: Hospital.all.sample
  )
end

puts "Coverages created!"
puts "Seeding done!"
