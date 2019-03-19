FactoryBot.define do
  factory :thermostat_read do
    thermostat      { create(:thermostat) }
    temperature     { 1.5 }
    humidity        { 2.5 }
    battery_charge  { 3.5 }
  end
end


