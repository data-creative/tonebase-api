require 'rails_helper'
require_relative '../../../support/api/v1/request'
require_relative '../../../support/api/v1/endpoints/index'
require_relative '../../../support/api/v1/endpoints/show'
require_relative '../../../support/api/v1/endpoints/create'
require_relative '../../../support/api/v1/endpoints/update'
require_relative '../../../support/api/v1/endpoints/destroy'

RSpec.describe Api::V1::AdsController, type: :controller do
  include_context "authenticate requests using valid token"

  describe "GET #index" do
    it_behaves_like "an index endpoint", Ad
    it_behaves_like "an index endpoint which paginates", Ad
  end

  describe "GET #show" do
    it_behaves_like "a show endpoint", Ad
  end

  describe "POST #create" do
    it_behaves_like "a create endpoint", Ad  do
      let(:advertiser){ create(:advertiser)}
      let(:resource_params){
        {
          advertiser_id: advertiser.id,
          title: "Buy a Fendie",
          content: "Fendie sitars are the best.",
          url: "https://www.fendie.com/promo",
          image_url: "https://my-bucket.s3.amazonaws.com/my-dir/my-image.jpg"
        }
      }
    end

    it_behaves_like "a create endpoint which validates presence", Ad, [:advertiser, :title] do
      let(:resource_params){ {advertiser_id: "", title: ""} }
    end
  end

  describe "PUT #update" do
    it_behaves_like "an update endpoint", Ad, {image_url: "https://www.my-site.com/updated.jpg"}
    it_behaves_like "an update endpoint which validates presence", Ad, [:title]
  end

  describe "DELETE #destroy" do
    it_behaves_like "a destroy endpoint", Ad
  end
end
