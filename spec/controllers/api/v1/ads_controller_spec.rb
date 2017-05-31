require 'rails_helper'
require_relative '../../../support/api/v1/index'
require_relative '../../../support/api/v1/show'
require_relative '../../../support/api/v1/create'
require_relative '../../../support/api/v1/update'
require_relative '../../../support/api/v1/destroy'

RSpec.describe Api::V1::AdsController, type: :controller do
  describe "GET #index" do
    it_behaves_like "an index endpoint", Ad, :title
  end

  describe "GET #show" do
    it_behaves_like "a show endpoint", Ad, :title
  end

  describe "POST #create" do
    it_behaves_like "a create endpoint which validates associations", Ad, [Advertiser], {
      title: "Buy a Fendie",
      message: "Fendie sitars are the best.",
      url: "https://www.fendie.com/promo",
      image_url: "https://my-bucket.s3.amazonaws.com/my-dir/my-image.jpg"
    }

    it_behaves_like "a create endpoint which validates presence", Ad, :title
    it_behaves_like "a create endpoint which validates uniqueness", Ad, :title
  end

  describe "PUT #update" do
    it_behaves_like "an update endpoint", Ad, {image_url: "https://www.my-site.com/updated.jpg"}
    it_behaves_like "an update endpoint which validates presence", Ad, :title
    it_behaves_like "an update endpoint which validates uniqueness", Ad, :title
  end

  describe "DELETE #destroy" do
    it_behaves_like "a destroy endpoint", Ad
  end
end
