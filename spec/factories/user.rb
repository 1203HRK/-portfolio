FactoryBot.define do
  factory :user do
    name                  { Faker::Name.name }
    email                 { Faker::Internet.email }
    password              { Faker::Lorem.characters(number:7) }
    password_confirmation { Faker::Lorem.characters(number:7) }
  end
end