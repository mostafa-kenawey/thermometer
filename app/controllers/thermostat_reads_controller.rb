class ThermostatReadsController < ApplicationController

  def create
    thermostat_read = ThermostatReads::CreateService.new(current_thermostat, thermostat_read_params).execute
    if thermostat_read.valid?
      render :json => {:success => true, thermostat_read: thermostat_read.as_json}, status: :created
    else
      render_errors(thermostat_read.errors.messages)
    end
  end

  def show
    thermostat_read = ThermostatReads::ShowService.new(current_thermostat, params[:id]).execute
    if thermostat_read
      render :json => {:success => true, thermostat_read: thermostat_read.as_json}, status: :created
    else
      render_not_found
    end
  end

  #######
  private
  #######

end
