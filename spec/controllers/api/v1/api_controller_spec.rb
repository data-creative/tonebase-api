require 'rails_helper'
require_relative '../../../support/api/v1/response'

RSpec.describe Api::V1::ApiController, type: :controller do

  # Requires request to have header... "HTTP_AUTHORIZATION"=>"Token token=\"abc123\"",
  describe "Authentication", "GET #hello" do
    context "request without a client token" do
      let(:response){ get(:hello, params: {format: 'json'}) }

      it "should be unsuccessful (unauthorized)" do
        expect(response.status).to eql(401)
        expect(response.message).to eql("Unauthorized")
      end
    end

    #context "request with invalid client token" do
    #  it "should return an 'invalid token' error message" do
    #    binding.pry
    #  end
    #end

    context "request with valid client token" do
      before :each do
        token = 'abc123'
        auth = ActionController::HttpAuthentication::Token.encode_credentials(token) #> Token token="abc123"
        request.headers.merge!({'HTTP_AUTHORIZATION': auth})
      end

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
