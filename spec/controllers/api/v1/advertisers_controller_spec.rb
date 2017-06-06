require 'rails_helper'
require_relative '../../../support/api/v1/index'
require_relative '../../../support/api/v1/show'
require_relative '../../../support/api/v1/create'
require_relative '../../../support/api/v1/update'
require_relative '../../../support/api/v1/destroy'
require_relative '../../../support/api/v1/request'

RSpec.describe Api::V1::AdvertisersController, type: :controller do
  include_context "authenticate requests using valid token"

  describe "GET #index" do
    it_behaves_like "an index endpoint", Advertiser
  end

  describe "GET #show" do
    it_behaves_like "a show endpoint", Advertiser
  end

  describe "POST #create" do
    it_behaves_like "a create endpoint", Advertiser do
      let(:resource_params){
        {
          name: "Strattle",
          description: "A sitar distribution company."
        }
      }
    end

    it_behaves_like "a create endpoint which validates presence", Advertiser, [:name]

    it_behaves_like "a create endpoint which validates uniqueness", Advertiser, [:name] do
      let!(:other_advertiser){ create(:advertiser) }
      let(:resource_params){ {name: other_advertiser.name} }
    end
  end

  describe "PUT #update" do
    it_behaves_like "an update endpoint", Advertiser, {description: "A sitar distribution company."}
    it_behaves_like "an update endpoint which validates presence", Advertiser, [:name]
    it_behaves_like "an update endpoint which validates uniqueness", Advertiser, :name
  end

  describe "DELETE #destroy" do
    it_behaves_like "a destroy endpoint", Advertiser
  end
end
