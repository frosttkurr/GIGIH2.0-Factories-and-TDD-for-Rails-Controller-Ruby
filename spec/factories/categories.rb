FactoryBot.define do
  factory :category do
    name { "Main Dish" }
  end

  factory :invalid_category, parent: :food do
    name { nil }
  end
end
