require 'rails_helper'
require_relative '../../../support/api/v1/request'
require_relative '../../../support/api/v1/response'

RSpec.describe Api::V1::MetricsController, type: :controller do
  include_context "authenticate requests using valid token"

  describe "GET #total_users" do
    let!(:users){ [ create(:limited_access_user), create(:full_access_user), create(:artist), create(:admin) ] }
    let(:response){  get(:total_users, params: {format: 'json'})  }

    it "returns the number of total users" do
      expect(parsed_response["total"]).to eql(users.count)
    end
  end
end
