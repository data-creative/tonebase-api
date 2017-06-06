require 'rails_helper'
require_relative '../../../support/api/v1/create'
require_relative '../../../support/api/v1/destroy'
require_relative '../../../support/api/v1/request'

RSpec.describe Api::V1::AdInstrumentsController, type: :controller do
  include_context "authenticate requests using valid token"

  describe "POST #create" do
    it_behaves_like "a create endpoint", AdInstrument  do
      let(:ad){ create(:ad)}
      let(:instrument){ create(:instrument) }
      let(:resource_params){
        {
          ad_id: ad.id,
          instrument_id: instrument.id,
        }
      }
    end

    it_behaves_like "a create endpoint which validates presence", AdInstrument, [:ad, :instrument] do
      let(:resource_params){ {ad_id: "", instrument_id: ""} }
    end
  end

  describe "DELETE #destroy" do
    it_behaves_like "a destroy endpoint", AdInstrument
  end
end
