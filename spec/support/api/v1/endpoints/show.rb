require_relative "../response"

shared_examples_for "a show endpoint" do |model_class|
  let!(:resource) { create(model_class.name.underscore.to_sym) }

  describe "response" do
    context "with valid params" do
      let(:response){  get(:show, params: {format: 'json', id: resource.id})  }

      it "should be successful (ok)" do
        expect(response.status).to eql(200)
      end

      it "should return an object" do
        expect(parsed_response).to be_kind_of(Hash)
      end
    end

    context "with invalid params (wrong id)" do
      let(:response){  get(:show, params: {format: 'json', id: "OOPS" })  }

      it "should be unsuccessful (not_found)" do
        expect(response.status).to eql(404)
        expect(response.message).to eql("Not Found")
      end

      it "should return a 'not found' error message" do
        expect(parsed_response["id"]).to include("not found")
      end
    end
  end
end
