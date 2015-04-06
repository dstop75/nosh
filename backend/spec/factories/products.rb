FactoryGirl.define do
  factory :product do
    name Faker::Lorem.word
    description Faker::Lorem.sentence
    price Faker::Commerce.price
    image_url Faker::Internet.url
  end

end
