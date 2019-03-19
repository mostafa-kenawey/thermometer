require 'sidekiq/api'

module ThermostatReads
  class ShowService < ::BaseService
    attr_reader :thermostat_read_number, :current_thermostat, :thermostat_read

    def initialize(thermostat, number = {})
      @current_thermostat = thermostat
      @thermostat_read_number = number
    end

    def _execute
      find_in_db || find_in_sidekiq
      thermostat_read
    end

    #######
    private
    #######

    def find_in_db
      @thermostat_read = current_thermostat.thermostat_reads.where(number: thermostat_read_number).first
    end

    def find_in_sidekiq
      arguments = find_in_queue
      @thermostat_read = current_thermostat.thermostat_reads.build(arguments.except("_aj_symbol_keys")) if arguments.any?
    end

    def find_in_queue
      queue_arguments = {}
      queue.each do |job|
        arguments = job.args.first["arguments"]
        number = arguments[1]["number"]
        queue_arguments = arguments[1] if arguments[0] == current_thermostat.id && number.to_s == thermostat_read_number
      end
      queue_arguments
    end

    def queue
      @_queue ||= Sidekiq::Queue.new(:thermostats)
    end

  end
end