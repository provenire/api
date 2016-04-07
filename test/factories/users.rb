FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    name  { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    company     { Faker::Company.name }
    location    { "#{Faker::Address.city}, #{Faker::Address.state}" }
    role        "user"

    password              "password"
    password_confirmation "password"

    factory :admin do
      role "admin"
    end
  end
end
