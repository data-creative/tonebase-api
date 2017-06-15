require 'rails_helper'
require_relative '../../../../support/api/v1/request'
require_relative '../../../../support/api/v1/endpoints/nested_index'

RSpec.describe Api::V1::Users::FollowsController, type: :controller do
  include_context "authenticate requests using valid token"

  describe "GET #index" do
    it_behaves_like "a nested index endpoint" do
      let(:resource){ create(:user, :follower) }
      let(:nested_resources){ resource.follows }
      let(:request_params){ {user_id: resource.id} }
    end
  end

  describe "DELETE #destroy" do
    let(:model_class){ UserFollowship }
    let!(:user){ create(:user, :follower) }
    let(:follows){ user.follows }
    let(:artist){ follows.first}

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
