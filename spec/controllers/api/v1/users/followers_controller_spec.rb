require 'rails_helper'
require_relative '../../../../support/api/v1/request'
require_relative '../../../../support/api/v1/endpoints/nested_index'

RSpec.describe Api::V1::Users::FollowersController, type: :controller do
  include_context "authenticate requests using valid token"

  describe "GET #index" do
    it_behaves_like "a nested index endpoint" do
      let(:resource){ create(:artist, :with_followers) }
      let(:nested_resources){ resource.followers }
      let(:request_params){ {user_id: resource.id} }
    end
  end
end
