FactoryBot.define do
  factory :review do
    user_id {1}
    body { Faker::Lorem.characters(number:20) }
    trait :with_nested_instances do
      after(:create) do |item|
        create :item, id: item.id
      end
    end
  end
end
