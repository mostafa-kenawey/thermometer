module ThermostatReads
  class CreateService < ::BaseService
    attr_reader :params, :thermostat_read, :current_thermostat

    def initialize(thermostat, args = {})
      @current_thermostat = thermostat
      @params = args
      @thermostat_read = ThermostatReadInput.new(params)
    end

    def _execute
      if valid?
        set_number
        perform_later_thermostat_read
      end
      thermostat_read
    end

    #######
    private
    #######

    def set_number
      thermostat_read.number = current_thermostat.increment_last_read_number!
    end

    def valid?
      thermostat_read.valid?
    end

    def perform_later_thermostat_read
      ThermostatReadJob.perform_later(current_thermostat.id, thermostat_read.as_json)
    end

  end
end