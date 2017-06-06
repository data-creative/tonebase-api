require 'rails_helper'
require_relative '../../../support/api/v1/request'
require_relative '../../../support/api/v1/endpoints/create'
require_relative '../../../support/api/v1/endpoints/destroy'

RSpec.describe Api::V1::UserFollowshipsController, type: :controller do
  include_context "authenticate requests using valid token"

  describe "POST #create" do
    it_behaves_like "a create endpoint", UserFollowship  do
      let(:user){ create(:user) }
      let(:followed_user){ create(:followed_user) }
      let(:resource_params){
        {
          user_id: user.id,
          followed_user_id: followed_user.id,
        }
      }
    end

    it_behaves_like "a create endpoint which validates presence", UserFollowship, [:user, :followed_user] do
      let(:resource_params){ {user_id: "", followed_user_id: ""} }
    end
  end

  describe "DELETE #destroy" do
    it_behaves_like "a destroy endpoint", UserFollowship
  end
end
