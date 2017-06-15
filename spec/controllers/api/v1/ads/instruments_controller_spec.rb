require 'rails_helper'
require_relative '../../../../support/api/v1/request'
require_relative '../../../../support/api/v1/endpoints/nested_destroy'

RSpec.describe Api::V1::Ads::InstrumentsController, type: :controller do
  include_context "authenticate requests using valid token"

  describe "DELETE #destroy" do
    it_behaves_like "a nested destroy endpoint", AdInstrument, :ad_id, :instrument_id do
      let!(:resource){ create(:ad, :with_instruments) }
      let(:nested_resource){ resource.instruments.first }
    end
  end
end
