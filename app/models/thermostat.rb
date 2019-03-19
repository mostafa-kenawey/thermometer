class Thermostat < ApplicationRecord
  validates :household_token, presence: true

  has_many :thermostat_reads

  def as_json(options={})
    {
      id: id,
      household_token: household_token,
      location: location
    }
  end
end
