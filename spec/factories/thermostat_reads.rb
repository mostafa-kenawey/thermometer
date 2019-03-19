FactoryBot.define do
  factory :thermostat_read do
    thermostat      { create(:thermostat) }
    temperature     { Faker::Number.decimal(2) }
    humidity        { Faker::Number.decimal(2) }
    battery_charge  { Faker::Number.decimal(2) }
  end
end


