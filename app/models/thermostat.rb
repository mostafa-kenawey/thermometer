class Thermostat < ApplicationRecord
  validates :household_token, presence: true

  def as_json(options={})
    {
      id: id,
      household_token: household_token,
      location: location
    }
  end
end
