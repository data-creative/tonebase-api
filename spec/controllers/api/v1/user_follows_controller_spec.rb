require 'rails_helper'
require_relative '../../../support/api/v1/create'
require_relative '../../../support/api/v1/destroy'

RSpec.describe Api::V1::UserFollowsController, type: :controller do
  describe "POST #create" do
    it_behaves_like "a create endpoint", UserFollow  do
      let(:artist){ create(:artist) }
      let(:follower){ create(:user) }
      let(:resource_params){
        {
          user_id: artist.id,
          follower_id: follower.id,
        }
      }
    end

    it_behaves_like "a create endpoint which validates presence", UserFollow, [:user, :follower] do
      let(:resource_params){ {user_id: "", follower_id: ""} }
    end
  end

  describe "DELETE #destroy" do
    it_behaves_like "a destroy endpoint", UserFollow
  end
end
