FactoryBot.define do
  factory :item do
    name  { Faker::Lorem.characters(number:10) }
  end
end