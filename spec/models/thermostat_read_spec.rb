require 'rails_helper'

RSpec.describe ThermostatRead, type: :model do
  let(:thermostat_read) { build(:thermostat_read) }

  context 'model' do
    let(:model) { ThermostatRead.new }

    [:temperature, :humidity, :battery_charge].each do |attr|
      context 'for #{attr}' do
        it 'doesnt allow nil values' do
          expect(model).not_to allow_value(nil).for(attr)
        end

        it 'allows float values' do
          expect(model).to allow_value(1.2).for(attr)
        end
      end
    end
  end

  context 'object' do
    it "has a valid record" do
      expect(thermostat_read).to be_valid
    end

    it "has a household_token delegated from thermostat" do
      expect(thermostat_read.household_token).not_to be_nil
    end

    context 'with number' do
      it "is generated before validate" do
        thermostat_read.valid?
        expect(thermostat_read.number).not_to be_nil
      end

      it "should be unique" do
        thermostat_read_2 = create(:thermostat_read)
        thermostat_read.number = thermostat_read_2.number
        thermostat_read.thermostat = thermostat_read_2.thermostat

        expect(thermostat_read).not_to be_valid
        expect(thermostat_read.errors).to include(:number)
      end
    end

    [:temperature, :humidity, :battery_charge].each do |attr|
      it "accepts #{attr}" do
        expect(build(:thermostat_read, attr => Faker::Number.number(16))).to be_valid
      end
    end

    [:temperature, :humidity, :battery_charge].each do |attr|
      it "is invalid without #{attr}" do
        thermostat_read_2 = build(:thermostat_read, attr => nil)

        expect(thermostat_read_2).not_to be_valid
        expect(thermostat_read_2.errors).to include(attr)
      end
    end

    it "returns as_json object" do
      expect(thermostat_read.as_json).to include({
        number: thermostat_read.number,
        household_token: thermostat_read.household_token,
        temperature: thermostat_read.temperature,
        humidity: thermostat_read.humidity,
        battery_charge: thermostat_read.battery_charge
      })
    end
  end

end
