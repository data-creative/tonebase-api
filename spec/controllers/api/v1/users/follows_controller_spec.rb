require 'rails_helper'
require_relative '../../../../support/api/v1/request'
require_relative '../../../../support/api/v1/endpoints/nested_index'
require_relative '../../../../support/api/v1/endpoints/nested_destroy'

RSpec.describe Api::V1::Users::FollowsController, type: :controller do
  include_context "authenticate requests using valid token"

  describe "GET #index" do
    it_behaves_like "a nested index endpoint", :user_id do
      let(:resource){ create(:user, :follower) }
      let(:nested_resources){ resource.user_followships }
    end

    it_behaves_like "a nested index endpoint which paginates", UserFollowship, :user_id do
      let(:resource){ create(:user, :follower, number_of_follows: 10) }
      let(:nested_resources){ resource.user_followships }
    end
  end

  describe "DELETE #destroy" do
    it_behaves_like "a nested destroy endpoint", UserFollowship, :user_id, :followed_user_id do
      let!(:resource){ create(:user, :follower) }
      let(:nested_resource){ resource.follows.first }
    end
  end
end
