class ThermostatReadsController < ApplicationController
  include JsonRenders
  include ThermostatAuth

  def create
    thermostat_read = ThermostatReads::CreateService.new(current_thermostat, thermostat_read_params).execute
    if thermostat_read.valid?
      render :json => {:success => true, thermostat_read: thermostat_read.as_json}, status: :created
    else
      render_errors(thermostat_read.errors.messages)
    end
  end

end
