require 'rails_helper'
require_relative '../../../support/api/v1/request'
require_relative '../../../support/api/v1/response'

RSpec.describe Api::V1::MetricsController, type: :controller do
  include_context "authenticate requests using valid token"

  let!(:users){ [ create(:limited_access_user), create(:full_access_user), create(:artist), create(:admin) ] }

  describe "GET #total_users" do
    let(:response){  get(:users_total, params: {format: 'json'})  }

    it "should be successful (ok)" do
      expect(response.status).to eql(200)
    end

    it "returns the number of total users" do
      expect(parsed_response["total"]).to eql(users.count)
    end
  end

  describe "GET #users_over_time" do
    let(:response){  get(:users_over_time, params: {format: 'json'})  }

    it "should be successful (ok)" do
      expect(response.status).to eql(200)
    end

    it "returns an array of user registration objects" do
      expect(parsed_response.count).to eql(users.count)
    end
  end
end
