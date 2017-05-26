require 'rails_helper'

RSpec.describe Api::V1::InstrumentsController, type: :controller do
  describe "#index" do
    let(:response){  get(:index, params: {format: 'json'})  }
    let(:parsed_response){ JSON.parse(response.body) }
    let(:instruments){ parsed_response["instruments"] }
    let(:instrument_names){ instruments.map{|i| i["name"]} }

    it "should be successful" do
      expect(response.status).to eql(200)
    end

    it "should include an array of instruments" do
      expect(instruments).to be_kind_of(Array)
      expect(instruments).to_not be_empty
    end

    it "should include an instrument named 'Guitar'" do
      expect(instrument_names).to include("Guitar")
    end
  end
end
