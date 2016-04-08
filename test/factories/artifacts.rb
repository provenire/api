FactoryGirl.define do
  factory :artifact do
    name            { Faker::Commerce.product_name }
    description     { Faker::Lorem.paragraph }

    alternate_names { Faker::Lorem.words([*0..10].sample) }
    artist          { Faker::Company.name }
    dimensions      ""
    date_created    "1200 BC"
    group           { [true, false].sample }
  end
end
