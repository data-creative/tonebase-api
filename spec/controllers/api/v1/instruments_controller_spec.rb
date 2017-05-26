require 'rails_helper'

RSpec.describe Api::V1::InstrumentsController, type: :controller do
  #let!(:instrument){ create(:instrument, name: "Sitar", description: "The sitar is a plucked stringed instrument used mainly in Hindustani music and Indian classical music.")}
  let(:parsed_response){ JSON.parse(response.body) }

  describe "#index" do
    let(:response){  get(:index, params: {format: 'json'})  }

    it "should be successful" do
      expect(response.status).to eql(200)
    end

    it "should include an array of instruments" do
      expect(parsed_response["instruments"]).to be_kind_of(Array)
      expect(parsed_response["instruments"]).to_not be_empty
    end

    it "should include an instrument named 'Guitar'" do
      instrument_names = parsed_response["instruments"].map{|i| i["name"]}
      expect(instrument_names).to include("Guitar")
    end
  end

  describe "#show" do
    let(:instrument){ create(:instrument) }
    let(:response){  get(:show, params: {format: 'json', id: instrument.id})  }

    it "should be successful" do
      expect(response.status).to eql(200)
    end

    it "should include an instrument object" do
      expect(parsed_response["instrument"]).to be_kind_of(Hash)
    end

    it "should include the requested instrument" do
      expect(parsed_response["instrument"]["name"]).to eql(instrument.name)
    end
  end
end
