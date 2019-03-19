require 'rails_helper'

RSpec.describe Thermostat, type: :model do
  let(:thermostat) { build(:thermostat) }

  context 'model' do
    let(:model) { Thermostat.new }

    it { should validate_presence_of(:household_token) }

    it { should have_many(:thermostat_reads).dependent(:destroy) }

    it 'allows nil values for location' do
      expect(model).to allow_value(nil).for(:location)
    end

    it 'doesnt allow nil values for household_token' do
      expect(model).not_to allow_value(nil).for(:household_token)
    end
  end

  context 'object' do
    it "has a valid record" do
      expect(thermostat).to be_valid
    end

    it "accepts household_token" do
      expect(build(:thermostat, household_token: Faker::Number.number(16))).to be_valid
    end

    it "accepts location" do
      expect(build(:thermostat, location: Faker::Address.full_address)).to be_valid
    end

    it "is invalid without household_token" do
      thermostat_2 = build(:thermostat, household_token: nil)

      expect(thermostat_2).not_to be_valid
      expect(thermostat_2.errors).to include(:household_token)
    end

    it "is valid without location" do
      expect(build(:thermostat, location: nil)).to be_valid
    end

    it "returns as_json object" do
      expect(thermostat.as_json).to include({
        household_token: thermostat.household_token,
        location: thermostat.location
      })
    end
  end

end
