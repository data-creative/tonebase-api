require 'rails_helper'

RSpec.describe Api::V1::InstrumentsController, type: :controller do
  let!(:instrument){ create(:instrument) }
  let(:parsed_response){ JSON.parse(response.body) }

  describe "GET #index" do
    let(:response){  get(:index, params: {format: 'json'})  }

    it "should be successful (ok)" do
      expect(response.status).to eql(200)
    end

    it "should return an array" do
      expect(parsed_response).to be_kind_of(Array)
    end

    it "should include all instruments" do
      instrument_names = parsed_response.map{|i| i["name"]}
      expect(instrument_names).to include(instrument.name)
    end
  end

  describe "GET #show" do
    context "with valid params" do
      let(:response){  get(:show, params: {format: 'json', id: instrument.id})  }

      it "should be successful (ok)" do
        expect(response.status).to eql(200)
      end

      it "should return an object" do
        expect(parsed_response).to be_kind_of(Hash)
      end

      it "should include the requested instrument" do
        expect(parsed_response["name"]).to eql(instrument.name)
      end
    end

    context "with invalid params (wrong id)" do
      let(:response){  get(:show, params: {format: 'json', id: instrument.id * 40 })  }

      it "should be unsuccessful (not_found)" do
        expect(response.status).to eql(404)
        expect(response.message).to eql("Not Found")
      end

      it "should return a 'not found' error message" do
        expect(parsed_response["id"]).to include("not found")
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:instrument_params){ {name: "Tambourine", description: "Shake it."} }
      let!(:response){ post(:create, params: {format: 'json', instrument: instrument_params}) }

      it "should be successful (created)" do
        expect(response.status).to eql(201)
        expect(response.message).to eql("Created")
      end

      it "should create a new instrument" do
        expect(Instrument.count).to eql(2)
      end
    end

    context "with invalid params (duplicate name)" do
      let(:instrument_params){ {name: instrument.name, description: "Shake it."} }
      let!(:response){ post(:create, params: {format: 'json', instrument: instrument_params}) }

      it "should be unsuccessful (unprocessable_entity)" do
        expect(response.status).to eql(422)
        expect(response.message).to eql("Unprocessable Entity")
      end

      it "should return a uniqueness validation error message" do
        expect(parsed_response["name"]).to include("has already been taken")
      end
    end

    context "with invalid params (missing name)" do
      let(:instrument_params){ {name: "", description: "Shake it."} }
      let!(:response){ post(:create, params: {format: 'json', instrument: instrument_params}) }

      it "should be unsuccessful (unprocessable_entity)" do
        expect(response.status).to eql(422)
        expect(response.message).to eql("Unprocessable Entity")
      end

      it "should return a presence validation error message" do
        expect(parsed_response["name"]).to include("can't be blank")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:instrument_params){ {description: "Shake it some more."} }
      let!(:response){ put(:update, params: {format: 'json', id: instrument.id, instrument: instrument_params}) }

      it "should be successful (updated)" do
        expect(response.status).to eql(200)
        expect(response.message).to eql("OK")
      end

      it "should update the instrument" do
        instrument.reload
        expect(instrument.description).to eql(instrument_params[:description])
      end
    end

    context "with invalid params (blank name)" do
      let(:instrument_params){ {name: ""} }
      let!(:response){ put(:update, params: {format: 'json', id: instrument.id, instrument: instrument_params}) }

      it "should be unsuccessful (unprocessable_entity)" do
        expect(response.status).to eql(422)
        expect(response.message).to eql("Unprocessable Entity")
      end

      it "should return a presence validation error message" do
        expect(parsed_response["name"]).to include("can't be blank")
      end
    end

    context "with invalid params (duplicate name)" do
      let!(:other_instrument){ create(:instrument, name: "My Other Instrument")}
      let(:instrument_params){ {name: other_instrument.name} }
      let!(:response){ put(:update, params: {format: 'json', id: instrument.id, instrument: instrument_params}) }

      it "should be unsuccessful (unprocessable_entity)" do
        expect(response.status).to eql(422)
        expect(response.message).to eql("Unprocessable Entity")
      end

      it "should return a presence validation error message" do
        expect(parsed_response["name"]).to include("has already been taken")
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:response){  delete(:destroy, params: {format: 'json', id: instrument.id})  }

    it "should be successful (destroyed)" do
      expect(response.status).to eql(204)
      expect(response.message).to eql("No Content")
    end

    it "should delete the resource" do
      expect(Instrument.count).to eql(0)
    end
  end
end
