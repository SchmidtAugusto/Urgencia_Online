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

MedicalRecord.destroy_all
Appointment.destroy_all
Coverage.destroy_all
PlanDetail.destroy_all
InsurancePlan.destroy_all
User.destroy_all
Hospital.destroy_all

puts "All previous instances destroyed!"

puts "Creating hospitals..."

hospitals = [['Sabará Hospital Infantil', 'Av. Angélica, 1987 - Consolação, São Paulo - SP, 01227-200', 'app/assets/images/hospitals/H-Infantil-Sabara.jpg'], ['Hospital Sírio Libanês', 'Rua Dona Adma Jafet, 115 - Bela Vista, São Paulo - SP, 01308-050', 'app/assets/images/hospitals/H-SirioLibanes.jpg'], ['Hospital Santa Catarina', 'Av. Paulista, 200 - Bela Vista, São Paulo - SP, 01310-000', 'app/assets/images/hospitals/H-Santa-Catarina.jpg'],
  ['Hospital Santa Paula', 'Av. Santo Amaro, 2468 - Brooklin, São Paulo - SP, 04556-100', 'app/assets/images/hospitals/H-Santa-Paula.jpg'], ['Hospital Alemão Oswaldo Cruz', 'R. Treze de Maio, 1815 - Bela Vista, São Paulo - SP, 01323-020', 'app/assets/images/hospitals/H-Alemão-Oswaldo-Cruz.jpg'],
  ['Hospital Israelita Albert Einstein', 'Av. Albert Einstein, 627/701 - Morumbi - CEP 05652- 900', 'app/assets/images/hospitals/H-Israelita-Albert-Einstein.jpg'], ['Hospital LeForte', 'Rua dos Três Irmãos, 121 - Morumbi, São Paulo - SP, 05615-190', 'app/assets/images/hospitals/H-Leforte.jpg'],
  ['Hospital Samaritano', 'R. Conselheiro Brotero, 1486 - Higienópolis, São Paulo - SP, 01232-010', 'app/assets/images/hospitals/H-Samaritano.jpg'], ['Hospital São Camilo', 'Av. Pompéia, 1178 - Pompeia, São Paulo - SP, 05022-001', 'app/assets/images/hospitals/H-São-Camilo.jpg'],
  ['Hospital São Luiz', 'Rua Engenheiro Oscar Americano, 840 - Jardim Guedala, São Paulo - SP, 05605-050', 'app/assets/images/hospitals/H-São-Luiz.jpg']]

puts "Seeding..."
hospitals.each do |hospital|
  h = Hospital.new(name: hospital[0], address: hospital[1])
  h.photo.attach(io: File.open(hospital[2]), filename: "#{hospital[0].downcase}.jpg")
  h.save!
  puts h.name
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

6.times do
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
    hospital: Hospital.find(9),
    description: Faker::Lorem.sentence(word_count: rand(3..10)),
    color_protocol: "Azul - não apresenta risco",
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
  cpf: Faker::Number.number(digits: 11),
  birthdate: Faker::Date.birthday(min_age: 18),
  admin: true
)
create_medical_records(User.last)

puts "Users created!"

puts "Creating insurance plans..."

plans = ["Amil", "Notre Dame Intermédia", "Bradesco Saúde", "Sul América Saúde", "Saúde Beneficência", "Hapvida", "Unimed", "Green Line", "São Cristóvão",
        "Trasmontano Saúde", "Santa Helena Saúde", "Porto Seguro Saúde", "São Francisco", "Blue Med Saúde", "Golden Cross", "Careplus"]

plans.each do |plan|
  h = InsurancePlan.create(name: plan)
  puts h.name
end

puts "Insurance plans created!"

puts "Creating plan details..."

5.times do
  PlanDetail.create!(
    insurance_plan: InsurancePlan.all.sample,
    product: rand(100..999),
    id_code: Faker::Number.number(digits: 6),
    plan: Faker::Company.buzzword,
    cns: Faker::Number.number(digits: 15),
    user: User.all.sample
  )
end

puts "Plan details created!"

puts "Creating coverages..."

20.times do
  Coverage.create(
    insurance_plan: InsurancePlan.all.sample,
    hospital: Hospital.all.sample
  )
end

puts "Coverages created!"
puts "Seeding done!"
