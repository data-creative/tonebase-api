require 'rails_helper'
require_relative '../../../../support/api/v1/request'
require_relative '../../../../support/api/v1/response'

RSpec.describe Api::V1::Users::FollowersController, type: :controller do
  include_context "authenticate requests using valid token"

  describe "GET #index" do
    describe "response" do
      context "when successful" do
        let!(:artist){ create(:artist, :with_followers) }
        let(:followers){ artist.followers }
        let(:response){ get(:index, params: {user_id: artist.id, format: 'json'}) }

        it "should be successful (ok)" do
          expect(response.status).to eql(200)
        end

        it "should be an array" do
          expect(parsed_response).to be_kind_of(Array)
        end

        it "should include resources" do
          expect(parsed_response.count).to eql(followers.count)
          expect(parsed_response.any?).to be true
        end
      end
    end
  end
end
