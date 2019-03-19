class ThermostatReadInput
  include ActiveModel::Model

  attr_accessor :temperature, :humidity, :battery_charge, :number

  validates :temperature, :humidity, :battery_charge, presence: true

  def as_json(options={})
    {
      number: number,
      temperature: temperature,
      humidity: humidity,
      battery_charge: battery_charge
    }
  end
end
