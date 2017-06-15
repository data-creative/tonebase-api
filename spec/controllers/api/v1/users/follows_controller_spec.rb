require 'rails_helper'
require_relative '../../../../support/api/v1/request'

RSpec.describe Api::V1::FollowsController, type: :controller do
  include_context "authenticate requests using valid token"

  describe "GET #index" do
    describe "response" do
      context "when successful" do
        let(:user){ create(:user, :follower) }
        let(:follows){ user.follows }
        let(:response){ get(:index, params: {user_id: user.id, format: 'json'}) }

        it "should be successful (ok)" do
          expect(response.status).to eql(200)
        end

        it "should be an array" do
          expect(parsed_response).to be_kind_of(Array)
        end

        it "should include resources belonging to the parent" do
          expect(parsed_response.count).to eql(follows.count)
          expect(parsed_response.any?).to be true
        end
      end
    end
  end


end
