require 'rails_helper'
require_relative '../../../support/api/v1/create'
require_relative '../../../support/api/v1/destroy'

RSpec.describe Api::V1::UserFavoriteVideosController, type: :controller do
  describe "POST #create" do
    it_behaves_like "a create endpoint", UserFavoriteVideo  do
      let(:user){ create(:user)}
      let(:video){ create(:video) }
      let(:resource_params){
        {
          user_id: user.id,
          video_id: video.id,
        }
      }
    end

    it_behaves_like "a create endpoint which validates presence", UserFavoriteVideo, [:user, :video] do
      let(:resource_params){ {user_id: "", video_id: ""} }
    end
  end

  describe "DELETE #destroy" do
    it_behaves_like "a destroy endpoint", UserFavoriteVideo
  end
end
