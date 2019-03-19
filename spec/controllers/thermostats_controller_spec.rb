require 'rails_helper'

RSpec.describe ThermostatsController, type: :controller do
  describe "GET #stats" do
    let(:thermostat) { create(:thermostat) }
    let(:thermostat_read) { create(:thermostat_read, thermostat: thermostat) }
    let(:valid_params) do
      {
        id: thermostat.id
      }
    end

    context "without household_token" do
      before do
        get :stats, params: valid_params
      end

      it "returns http unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "with valid parameters" do
      before do
        ActiveJob::Base.queue_adapter = :test
        @request.env['HTTP_HOUSEHOLD_TOKEN'] = thermostat.household_token
        get :stats, params: valid_params
      end

      it "returns http success" do
        expect(response).to have_http_status(:ok)
      end

      it "JSON body response contains expected attributes" do
        json_response = JSON.parse(response.body)
        expect(json_response.keys).to match_array(["thermostat_reads", "success"])
      end
    end

  end
end
