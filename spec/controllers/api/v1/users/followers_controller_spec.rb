require 'rails_helper'
require_relative '../../../../support/api/v1/request'
require_relative '../../../../support/api/v1/endpoints/nested_index'

RSpec.describe Api::V1::Users::FollowersController, type: :controller do
  include_context "authenticate requests using valid token"

  describe "GET #index" do
    it_behaves_like "a nested index endpoint", :user_id do
      let(:resource){ create(:artist, :with_followers) }
      let(:nested_resources){ resource.inverse_user_followships }
    end

    it_behaves_like "a nested index endpoint which paginates", UserFollowship, :user_id do
      let(:resource){ create(:artist, :with_followers, number_of_followers: 10) }
      let(:nested_resources){ resource.inverse_user_followships }
    end
  end
end
