FactoryBot.define do
  factory :thermostat do
    household_token    { Faker::Number.number(16) }
    location           { Faker::Address.full_address }
  end
end
