require_relative "../response"

shared_examples_for "a create endpoint which validates uniqueness" do |model_class, attribute_name|
  let!(:resource) { create(model_class.name.downcase.to_sym) }

  describe "response" do
    context "with invalid params (duplicate attribute value)" do
      let(:resource_params){ {attribute_name.to_sym => resource.send(attribute_name.to_sym)} }
      let(:response){ post(:create, params: {format: 'json', model_class.name.downcase.to_sym => resource_params}) }

      it "should be unsuccessful (unprocessable_entity)" do
        expect(response.status).to eql(422)
        expect(response.message).to eql("Unprocessable Entity")
      end

      it "should return a uniqueness validation error message" do
        expect(parsed_response[attribute_name.to_s]).to include("has already been taken")
      end

      it "should not create a resource" do
        expect{response}.to change{model_class.count}.by(0)
      end
    end
  end
end
