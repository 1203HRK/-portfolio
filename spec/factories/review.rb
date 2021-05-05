=begin
FactoryBot.define do
  factory :review do
    body { Faker::Lorem.characters(number:20) }
  end
end
=end