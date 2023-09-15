FactoryBot.define do 
  factory :user do
    email { Faker::Internet.email }
    role { "manager" }
    password { Faker::Internet.password }
    password_confirmation { password }
  end

  factory :restaurant do
    title { Faker::Lorem.words.join(" ") }
    description { Faker::Lorem.sentence }
    user { create(:user) }
  end

  factory :category do
    title { Faker::Lorem.words.join(" ") }
    description { Faker::Lorem.sentence }
    restaurant { create(:restaurant) }
  end

  factory :product do
    title { Faker::Lorem.words.join(" ") }
    description { Faker::Lorem.sentence }
    price { Faker::Commerce.price(range: 1..25) }
    category { create(:category) }
    restaurant { category.restaurant }
  end

  factory :table do
    title { Faker::Lorem.words.join(" ") }
    description { Faker::Lorem.sentence }
    restaurant { create(:restaurant) }
  end

end