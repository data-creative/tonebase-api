require 'rails_helper'
require_relative '../../../../support/api/v1/request'
require_relative '../../../../support/api/v1/endpoints/nested_index'
require_relative '../../../../support/api/v1/endpoints/nested_destroy'

RSpec.describe Api::V1::Users::FavoriteVideosController, type: :controller do
  include_context "authenticate requests using valid token"

  describe "GET #index" do
    it_behaves_like "a nested index endpoint", :user_id do
      let(:resource){ create(:user, :with_favorite_videos) }
      let(:nested_resources){ resource.user_favorite_videos }
    end

    it_behaves_like "a nested index endpoint which paginates", UserFavoriteVideo, :user_id do
      let(:resource){ create(:user, :with_favorite_videos, number_of_favorite_videos: 10) }
      let(:nested_resources){ resource.user_favorite_videos }
    end
  end

  describe "DELETE #destroy" do
    it_behaves_like "a nested destroy endpoint", UserFavoriteVideo, :user_id, :video_id do
      let!(:resource){ create(:user, :with_favorite_videos) }
      let(:nested_resource){ resource.favorite_videos.first }
    end
  end
end
