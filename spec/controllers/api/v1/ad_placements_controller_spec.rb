require 'rails_helper'
require_relative '../../../support/api/v1/request'
require_relative '../../../support/api/v1/endpoints/index'
require_relative '../../../support/api/v1/endpoints/show'
require_relative '../../../support/api/v1/endpoints/create'
require_relative '../../../support/api/v1/endpoints/update'
require_relative '../../../support/api/v1/endpoints/destroy'

RSpec.describe Api::V1::AdPlacementsController, type: :controller do
  include_context "authenticate requests using valid token"

  describe "GET #index" do
    it_behaves_like "an index endpoint", AdPlacement
  end

  describe "GET #show" do
    it_behaves_like "a show endpoint", AdPlacement
  end

  describe "POST #create" do
    it_behaves_like "a create endpoint", AdPlacement  do
      let(:ad){ create(:ad)}
      let(:resource_params){
        {
          ad_id: ad.id,
          start_date: "2017-07-01",
          end_date: "2017-07-08",
          price: 25000
        }
      }
    end

    it_behaves_like "a create endpoint which validates presence", AdPlacement, [:ad, :start_date, :end_date, :price] do
      let(:resource_params){ {ad_id: "", start_date:"", end_date:"", price:""} }
    end
  end

  describe "PUT #update" do
    it_behaves_like "an update endpoint", AdPlacement, {price: 22222}

    it_behaves_like "an update endpoint which validates presence", AdPlacement, [:ad, :start_date, :end_date, :price] do
      let(:resource_params){ {ad_id: "", start_date:"", end_date:"", price:""} }
    end
  end

  describe "DELETE #destroy" do
    it_behaves_like "a destroy endpoint", AdPlacement
  end
end
