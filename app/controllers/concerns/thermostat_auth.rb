module ThermostatAuth
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_thermostat
  end

  private

  def thermostat_read_params
    params.require(:thermostat_read).permit(:temperature, :humidity, :battery_charge)
  end

  def current_thermostat
    @_current_thermostat ||= Thermostat.where(household_token: household_token).first if household_token
  end

  def authenticate_thermostat
    unless current_thermostat
      render_unauthorized and return
    end
  end

  def household_token
    @_household_token ||= request.env["HTTP_HOUSEHOLD_TOKEN"]
  end
end
