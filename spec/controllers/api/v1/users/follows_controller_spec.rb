require 'rails_helper'
require_relative '../../../../support/api/v1/request'
require_relative '../../../../support/api/v1/response'

RSpec.describe Api::V1::FollowsController, type: :controller do
  include_context "authenticate requests using valid token"

  let!(:user){ create(:user, :follower) }
  let(:follows){ user.follows }
  let(:artist){ follows.first}

  describe "GET #index" do
    describe "response" do
      context "when successful" do
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

  describe "DELETE #destroy" do
    let(:model_class){ UserFollowship }

    context "with valid params" do
      let(:response){ delete(:destroy, params: {user_id: user.id, followed_user_id: artist.id, format: 'json'}) }

      it "should be successful (destroyed)" do
        expect(response.status).to eql(204)
        expect(response.message).to eql("No Content")
      end

      it "should destroy the specified resource" do
        expect{response}.to change{model_class.count}.by(-1)
      end
    end

    context "with invalid params (wrong id)" do
      let(:response){ delete(:destroy, params: {user_id: user.id, followed_user_id: "OOPS", format: 'json'}) }

      it "should be unsuccessful (not_found)" do
        expect(response.status).to eql(404)
        expect(response.message).to eql("Not Found")
      end

      it "should return a 'not found' error message" do
        expect(parsed_response["id"]).to include("not found")
      end

      it "should not destroy anything" do
        expect{response}.to change{model_class.count}.by(0)
      end
    end
  end
end
