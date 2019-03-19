class ThermostatReadJob < ApplicationJob
  queue_as :thermostats
  attr_accessor :thermostat, :thermostat_read

  def perform(thermostat_id, attrs)
    @thermostat = Thermostat.find(thermostat_id)
    @thermostat_read = thermostat.thermostat_reads.build(attrs)
    save_thermostat_read
  end

  #######
  private
  #######

  def save_thermostat_read
    thermostat.save!
  end
end