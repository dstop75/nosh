FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    password Faker::Lorem.word
    token "a47a8e54b11c4de5a4a351734c80a14a"
  end
end
