require_relative "./response"

shared_examples_for "a show endpoint" do |model_class, attribute_name|
  let!(:resource) { create(model_class.name.downcase.to_sym) }

  describe "response" do
    context "with valid params" do
      let(:response){  get(:show, params: {format: 'json', id: resource.id})  }

      it "should be successful (ok)" do
        expect(response.status).to eql(200)
      end

      it "should return an object" do
        expect(parsed_response).to be_kind_of(Hash)
      end

      it "should include the requested resource" do
        expect(parsed_response[attribute_name.to_s]).to eql(resource.send(attribute_name.to_sym))
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
