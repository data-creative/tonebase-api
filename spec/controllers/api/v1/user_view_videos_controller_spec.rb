require 'rails_helper'
require_relative '../../../support/api/v1/request'
require_relative '../../../support/api/v1/endpoints/index'
require_relative '../../../support/api/v1/endpoints/show'
require_relative '../../../support/api/v1/endpoints/create'

RSpec.describe Api::V1::UserViewVideosController, type: :controller do
  include_context "authenticate requests using valid token"

  describe "GET #index" do
    it_behaves_like "an index endpoint", UserViewVideo
  end

  describe "GET #show" do
    it_behaves_like "a show endpoint", UserViewVideo
  end

  describe "POST #create" do
    it_behaves_like "a create endpoint", UserViewVideo  do
      let(:user){ create(:user)}
      let(:video){ create(:video) }
      let(:resource_params){
        {
          user_id: user.id,
          video_id: video.id,
        }
      }
    end

    it_behaves_like "a create endpoint which validates presence", UserViewVideo, [:user, :video] do
      let(:resource_params){ {user_id: "", video_id: ""} }
    end
  end
end
