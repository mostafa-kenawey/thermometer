class ApplicationController < ActionController::API
  include JsonRenders
  include ThermostatAuth
end
