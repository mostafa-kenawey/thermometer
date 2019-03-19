module SetNumber
  extend ActiveSupport::Concern

  included do
    validates :number, presence: true, if: :thermostat_id?
    validates :number, number_uniqueness: true, on: :create
    before_validation :set_number, on: :create, if: :thermostat_id?

    delegate :household_token, :last_read_number, :increment_last_read_number!, to: :thermostat, allow_nil: true
  end

  #######
  private
  #######

  def set_number
    self.number ||= increment_last_read_number!
  end

end
