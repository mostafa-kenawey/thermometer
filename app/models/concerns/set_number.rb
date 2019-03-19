module SetNumber
  extend ActiveSupport::Concern

  included do
    validates :number, presence: true, if: :thermostat_id?
    validates :number, number_uniqueness: true, on: :create
    before_validation :set_number, on: :create, if: :thermostat_id?
  end

  #######
  private
  #######

  def set_number
    self.number ||= next_number
  end

  def next_number
    ThermostatRead.joins(:thermostat).where("thermostats.household_token" => self.household_token).order("number DESC").limit(1).first.try(:number).to_i+1
  end

end
