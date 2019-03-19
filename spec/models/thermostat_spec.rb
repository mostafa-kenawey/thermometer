require 'rails_helper'

RSpec.describe Thermostat, type: :model do
  let(:thermostat) { build(:thermostat) }

  it "has a valid record" do
    expect(thermostat).to be_valid
  end

  it "has household_token" do
    expect(build(:thermostat, household_token: Faker::Number.number(16))).to be_valid
  end

  it "has location" do
    expect(build(:thermostat, location: Faker::Address.full_address)).to be_valid
  end

  it "is invalid without household_token" do
    expect(build(:thermostat, household_token: nil)).not_to be_valid
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
