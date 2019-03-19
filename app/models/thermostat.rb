class Thermostat < ApplicationRecord
  validates :household_token, presence: true

  has_many :thermostat_reads, dependent: :destroy

  def as_json(options={})
    {
      id: id,
      household_token: household_token,
      location: location,
      last_read_number: last_read_number
    }
  end

  def increment_last_read_number!
    new_number = last_read_number+1
    update!(last_read_number: new_number)
    new_number
  end

end
