class NumberUniquenessValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    if check_number_and_household_token(record, value) && check_number_exists(record, attribute, value)
      record.errors.add(attribute, "exists")
    end
  end

  private

  def check_number_exists(record, attribute, value)
    thermostat_read = ThermostatRead.joins(:thermostat)
    thermostat_read = thermostat_read.where("thermostats.household_token" => household_token(record))
    thermostat_read = thermostat_read.order("#{attribute} DESC").limit(1)
    thermostat_read.where(attribute => value).any?
  end

  def household_token(record)
    record.thermostat.try(:household_token)
  end

  def check_number_and_household_token(record, value)
    !!value && household_token(record)
  end

end
