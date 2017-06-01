require_relative "../response"

shared_examples_for "an update endpoint which validates presence" do |model_class, attribute_name|
  let!(:resource) { create(model_class.name.downcase.to_sym) }

  describe "response" do
    context "with invalid params (blank attribute value)" do
      let(:resource_params){ {attribute_name.to_sym => ""} }
      let!(:response){ post(:update, params: {format: 'json', id: resource.id, model_class.name.downcase.to_sym => resource_params}) }

      it "should be unsuccessful (unprocessable_entity)" do
        expect(response.status).to eql(422)
        expect(response.message).to eql("Unprocessable Entity")
      end

      it "should return a presence validation error message" do
        expect(parsed_response[attribute_name.to_s]).to include("can't be blank")
      end
    end
  end
end
