class ThermostatsController < ApplicationController

  def stats
    thermostat_reads = Thermostats::StatsService.new(current_thermostat).execute
    render :json => {:success => true, thermostat_reads: thermostat_reads}, status: :ok
  end

  #######
  private
  #######

end
