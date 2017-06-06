require 'rails_helper'
require_relative '../../../support/api/v1/request'
require_relative '../../../support/api/v1/endpoints/index'
require_relative '../../../support/api/v1/endpoints/show'
require_relative '../../../support/api/v1/endpoints/create'
require_relative '../../../support/api/v1/endpoints/update'
require_relative '../../../support/api/v1/endpoints/destroy'

RSpec.describe Api::V1::InstrumentsController, type: :controller do
  include_context "authenticate requests using valid token"

  describe "GET #index" do
    it_behaves_like "an index endpoint", Instrument
  end

  describe "GET #show" do
    it_behaves_like "a show endpoint", Instrument
  end

  describe "POST #create" do
    it_behaves_like "a create endpoint", Instrument do
      let(:resource_params){
        {
          name: "Tambourine",
          description: "Shake it."
        }
      }
    end

    it_behaves_like "a create endpoint which validates presence", Instrument, [:name]

    it_behaves_like "a create endpoint which validates uniqueness", Instrument, [:name] do
      let!(:other_instrument){ create(:instrument) }
      let(:resource_params){ {name: other_instrument.name} }
    end
  end

  describe "PUT #update" do
    it_behaves_like "an update endpoint", Instrument, {description: "Shake it some more."}
    it_behaves_like "an update endpoint which validates presence", Instrument, [:name]
    it_behaves_like "an update endpoint which validates uniqueness", Instrument, :name
  end

  describe "DELETE #destroy" do
    it_behaves_like "a destroy endpoint", Instrument
  end
end
