FactoryGirl.define do
  factory :person do
    name          { Faker::Name.name }
    description   { Faker::Lorem.paragraph }
    gender        { ['male', 'female', 'unknown'].sample }
    date_of_birth { [nil, Faker::Date.between(100.years.ago, Date.today)].sample }
    date_of_death { [nil, Faker::Date.between(100.years.ago, Date.today)].sample }
    nationality   { Faker::Address.country }
  end
end
