require 'rails_helper'

RSpec.describe ThermostatReadsController, type: :controller do

  describe "POST #create" do
    let(:thermostat) { create(:thermostat) }
    let(:valid_params) do
      {
        thermostat_read: {
          temperature: 1.1,
          humidity: 2.2,
          battery_charge: 3.3
        }
      }
    end

    let(:invalid_params) do
      {
        thermostat_read: {
          temperature: '',
          humidity: '',
          battery_charge: ''
        }
      }
    end

    context "without household_token" do
      before do
        post :create, params: valid_params
      end

      it "returns http unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "with invalid params" do
      before do
        @request.env['HTTP_HOUSEHOLD_TOKEN'] = thermostat.household_token
        post :create, params: invalid_params
      end

      it "returns http unauthorized" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with valid parameters" do
      before do
        ActiveJob::Base.queue_adapter = :test
        @request.env['HTTP_HOUSEHOLD_TOKEN'] = thermostat.household_token
        post :create, params: valid_params
      end

      it "returns http success" do
        expect(response).to have_http_status(:created)
      end

      it "JSON body response contains expected attributes" do
        json_response = JSON.parse(response.body)
        expect(json_response["thermostat_read"].keys).to match_array(["battery_charge", "humidity", "number", "temperature"])
      end

      it "JSON body response contains expected values" do
        thermostat.reload
        json_response = JSON.parse(response.body)
        expect(json_response["thermostat_read"]).to include({
          "battery_charge" => valid_params[:thermostat_read][:battery_charge].to_s,
          "temperature" => valid_params[:thermostat_read][:temperature].to_s,
          "humidity" => valid_params[:thermostat_read][:humidity].to_s,
          "number" => thermostat.last_read_number
        })
      end

      it "has enqueued job" do
        expect {
          post(:create, params: valid_params)
        }.to have_enqueued_job
      end
    end
  end

  describe "GET #show" do
    let(:thermostat) { create(:thermostat) }
    let(:thermostat_read) { create(:thermostat_read, thermostat: thermostat) }
    let(:valid_params) do
      {
        id: thermostat_read.number
      }
    end

    let(:invalid_params) do
      {
        id: 999
      }
    end

    context "with valid parameters" do
      before do
        ActiveJob::Base.queue_adapter = :test
        @request.env['HTTP_HOUSEHOLD_TOKEN'] = thermostat.household_token
        get :show, params: valid_params
      end

      it "returns http success" do
        expect(response).to have_http_status(:created)
      end

      it "JSON body response contains expected attributes" do
        json_response = JSON.parse(response.body)
        expect(json_response["thermostat_read"].keys).to match_array(["battery_charge", "humidity", "number", "temperature", "household_token"])
      end

      it "JSON body response contains expected values" do
        thermostat.reload
        json_response = JSON.parse(response.body)
        expect(json_response["thermostat_read"]).to include({
          "battery_charge" => thermostat_read.battery_charge,
          "temperature" => thermostat_read.temperature,
          "humidity" => thermostat_read.humidity,
          "household_token" => thermostat_read.household_token,
          "number" => thermostat_read.number
        })
      end
    end

    context "with invalid parameters" do
      before do
        ActiveJob::Base.queue_adapter = :test
        @request.env['HTTP_HOUSEHOLD_TOKEN'] = thermostat.household_token
        get :show, params: invalid_params
      end

      it "returns http success" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
