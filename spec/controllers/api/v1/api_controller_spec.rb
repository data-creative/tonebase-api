require 'rails_helper'
require_relative '../../../support/api/v1/request'
require_relative '../../../support/api/v1/response'

RSpec.describe Api::V1::ApiController, type: :controller do
  describe "Authentication", "GET #hello" do
    context "request without a client token" do
      let(:response){ get(:hello, params: {format: 'json'}) }

      it "should be unsuccessful (unauthorized)" do
        expect(response.status).to eql(401)
        expect(response.message).to eql("Unauthorized")
      end
    end

    context "request with invalid client token" do
      include_context "authenticate requests using invalid token"
      let(:response){ get(:hello, params: {format: 'json'}) }

      it "should be unsuccessful (unauthorized)" do
        expect(response.status).to eql(401)
        expect(response.message).to eql("Unauthorized")
      end
    end

    context "request with valid client token" do
      include_context "authenticate requests using valid token"
      let(:response){ get(:hello, params: {format: 'json'}) }

      it "should be successful (ok)" do
        expect(response.status).to eql(200)
      end

      it "should return a welcome message" do
        expect(parsed_response["message"]).to eql("Congratulations, you have authenticated successfully.")
      end
    end
  end
end
