class ThermostatRead < ApplicationRecord
  include SetNumber

  validates :temperature, :humidity, :battery_charge, presence: true

  belongs_to :thermostat

  def as_json(options={})
    {
      id: id,
      number: number,
      household_token: household_token,
      temperature: temperature,
      humidity: humidity,
      battery_charge: battery_charge
    }
  end

end
