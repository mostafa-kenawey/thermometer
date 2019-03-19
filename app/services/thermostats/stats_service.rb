module Thermostats
  class StatsService < ::BaseService
    attr_reader :current_thermostat

    def initialize(thermostat)
      @current_thermostat = thermostat
    end

    def _execute
      thermostat_reads
    end

    #######
    private
    #######

    def thermostat_reads
      reads = {}
      reads_query.map{ |tr|
        reads[tr.created_at_date] = {
          max_temperature: tr.max_temperature,
          min_temperature: tr.min_temperature,
          avg_temperature: tr.avg_temperature,
          max_humidity: tr.max_humidity,
          min_humidity: tr.min_humidity,
          avg_humidity: tr.avg_humidity,
          max_battery_charge: tr.max_battery_charge,
          min_battery_charge: tr.min_battery_charge,
          avg_battery_charge: tr.avg_battery_charge
        }
      }
      reads
    end


    # One Query returns the MAX, MIN and AVG for temperature, humidity and battery_charge Grouped by date day
    def reads_query
      query = ThermostatRead.select("date(created_at) as created_at_date, MAX(temperature) as max_temperature, MIN(temperature) as min_temperature, AVG(temperature) as avg_temperature")
      query = query.select("MAX(humidity) as max_humidity, MIN(humidity) as min_humidity, AVG(humidity) as avg_humidity")
      query = query.select("MAX(battery_charge) as max_battery_charge, MIN(battery_charge) as min_battery_charge, AVG(battery_charge) as avg_battery_charge")
      query = query.group("date(created_at)").order("created_at_date desc")
      query
    end

  end
end