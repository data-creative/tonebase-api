require 'rails_helper'
require_relative '../../../support/api/v1/index'
require_relative '../../../support/api/v1/show'
require_relative '../../../support/api/v1/create'
require_relative '../../../support/api/v1/update'
require_relative '../../../support/api/v1/destroy'

RSpec.describe Api::V1::AdvertisersController, type: :controller do
  describe "GET #index" do
    it_behaves_like "an index endpoint", Advertiser, :name
  end

  describe "GET #show" do
    it_behaves_like "a show endpoint", Advertiser, :name
  end

  describe "POST #create" do
    it_behaves_like "a create endpoint", Advertiser, {
      name: "Strattle",
      description: "A sitar distribution company.",
      metadata: {contact: {name:"Jay", phone: "123456789", emailed_on:["2017-05-01", "2017-05-02", "2017-05-03"]} }
    }

    it_behaves_like "a create endpoint which validates presence", Advertiser, :name
    it_behaves_like "a create endpoint which validates uniqueness", Advertiser, :name
  end

  describe "PUT #update" do
    it_behaves_like "an update endpoint", Advertiser, {description: "A sitar distribution company."}
    it_behaves_like "an update endpoint which validates presence", Advertiser, :name
    it_behaves_like "an update endpoint which validates uniqueness", Advertiser, :name
  end

  describe "DELETE #destroy" do
    it_behaves_like "a destroy endpoint", Advertiser
  end
end
