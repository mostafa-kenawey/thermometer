FactoryBot.define do
  factory :thermostat do
    household_token             { Faker::Number.number(16) }
    location                    { Faker::Address.full_address }
    sequence :last_read_number do |n|
      "#{n}"
    end
  end
end
