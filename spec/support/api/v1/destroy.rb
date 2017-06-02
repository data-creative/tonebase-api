require_relative "./response"

shared_examples_for "a destroy endpoint" do |model_class|
  let!(:resource) { create(model_class.name.underscore.to_sym) }

  describe "response" do
    context "with valid params" do
      let(:response){  delete(:destroy, params: {format: 'json', id: resource.id})  }

      it "should be successful (destroyed)" do
        expect(response.status).to eql(204)
        expect(response.message).to eql("No Content")
      end

      it "should destroy the specified resource" do
        expect{response}.to change{model_class.count}.by(-1)
      end
    end

    context "with invalid params (wrong id)" do
      let(:response){  delete(:destroy, params: {format: 'json', id: "OOPS"})  }

      it "should be unsuccessful (not_found)" do
        expect(response.status).to eql(404)
        expect(response.message).to eql("Not Found")
      end

      it "should return a 'not found' error message" do
        expect(parsed_response["id"]).to include("not found")
      end

      it "should not destroy anything" do
        expect{response}.to change{model_class.count}.by(0)
      end
    end
  end
end
