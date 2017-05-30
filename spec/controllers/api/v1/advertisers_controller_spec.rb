require 'rails_helper'
require_relative '../../../support/api/v1/responses/list'
require_relative '../../../support/api/v1/responses/show'
require_relative '../../../support/api/v1/responses/create'
require_relative '../../../support/api/v1/responses/update'
require_relative '../../../support/api/v1/responses/destroy'

RSpec.describe Api::V1::AdvertisersController, type: :controller do
  let!(:advertiser){ create(:advertiser) }

  describe "GET #index", "response" do
    let(:response){  get(:index, params: {format: 'json'})  }

    it_behaves_like "a list response"

    it "should include all resources" do
      expect(parsed_response.map{|h| h["name"]}).to include(advertiser.name)
      expect(parsed_response.count).to eql(Advertiser.count)
    end
  end

  describe "GET #show", "response" do
    context "with valid params" do
      let(:response){  get(:show, params: {format: 'json', id: advertiser.id})  }

      it_behaves_like "a successful show response"

      it "should include the requested resource" do
        expect(parsed_response["name"]).to eql(advertiser.name)
      end
    end

    context "with invalid params (wrong id)" do
      let(:response){  get(:show, params: {format: 'json', id: "OOPS" })  }

      it_behaves_like "a resource not found response"
    end
  end

  describe "POST #create", "response" do
    context "with valid params" do
      let(:advertiser_params){ {name: "Strattle", description: "A sitar distribution company."} }
      let(:response){ post(:create, params: {format: 'json', advertiser: advertiser_params}) }

      it_behaves_like "a successful resource creation response", Advertiser
    end

    context "with valid metadata" do
      let(:advertiser_params){ {name: "Strattle", metadata: {contact:{name:"Jay", phone: "123456789", emailed_on:["2017-05-01", "2017-05-02", "2017-05-03"]}} } }
      let(:response){ post(:create, params: {format: 'json', advertiser: advertiser_params}) }

      it_behaves_like "a successful resource creation response", Advertiser

      it "should persist the unstructured metadata" do
        response
        advertiser = Advertiser.last
        expect(advertiser.metadata.deep_symbolize_keys).to eql(advertiser_params[:metadata])
      end
    end

    context "with invalid params (duplicate name)" do
      let(:advertiser_params){ {name: advertiser.name} }
      let(:response){ post(:create, params: {format: 'json', advertiser: advertiser_params}) }

      it_behaves_like "an unprocessable resource response"

      it_behaves_like "a uniqueness validation error response", :name
    end

    context "with invalid params (blank name)" do
      let(:advertiser_params){ {name: ""} }
      let(:response){ post(:create, params: {format: 'json', advertiser: advertiser_params}) }

      it_behaves_like "an unprocessable resource response"

      it_behaves_like "a presence validation error response", :name
    end
  end

  describe "PUT #update", "response" do
    context "with valid params" do
      let(:advertiser_params){ {description: "A sitar distribution company."} }
      let(:response){ put(:update, params: {format: 'json', id: advertiser.id, advertiser: advertiser_params}) }

      it_behaves_like "a successful resource update response"

      it "should update the resource" do
        response
        advertiser.reload
        expect(advertiser.description).to eql(advertiser_params[:description])
      end
    end

    context "with invalid params (wrong id)" do
      let(:advertiser_params){ {description: "A sitar distribution company."} }
      let(:response){ put(:update, params: {format: 'json', id: "OOPS", advertiser: advertiser_params}) }

      it_behaves_like "a resource not found response"
    end

    context "with invalid params (blank name)" do
      let(:advertiser_params){ {name: ""} }
      let(:response){ put(:update, params: {format: 'json', id: advertiser.id, advertiser: advertiser_params}) }

      it_behaves_like "an unprocessable resource response"

      it_behaves_like "a presence validation error response", :name
    end

    context "with invalid params (duplicate name)" do
      let!(:other_advertiser){ create(:advertiser, name: "My Other Advertiser")}
      let(:advertiser_params){ {name: other_advertiser.name} }
      let(:response){ put(:update, params: {format: 'json', id: advertiser.id, advertiser: advertiser_params}) }

      it_behaves_like "an unprocessable resource response"

      it_behaves_like "a uniqueness validation error response", :name
    end
  end

  describe "DELETE #destroy", "response" do
    context "with valid params" do
      let(:response){  delete(:destroy, params: {format: 'json', id: advertiser.id})  }

      it_behaves_like "a successful resource destruction response", Advertiser
    end

    context "with invalid params (wrong id)" do
      let(:response){  delete(:destroy, params: {format: 'json', id: "OOPS"})  }

      it_behaves_like "a resource not found response"
    end
  end
end
