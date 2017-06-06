require_relative "../../response"

shared_examples_for "an update endpoint which validates uniqueness" do |model_class, attribute_name|
  let!(:resource) { create(model_class.name.underscore.to_sym) }
  let!(:other_resource) { create(model_class.name.underscore.to_sym, attribute_name.to_sym => "#{resource.send(attribute_name.to_sym)}-EDITED") }

  describe "response" do
    context "with invalid params (duplicate attribute value)" do
      let(:resource_params){ {attribute_name.to_sym => other_resource.send(attribute_name.to_sym)} }
      let(:response){ post(:update, params: {format: 'json', id: resource.id, model_class.name.underscore.to_sym => resource_params}) }

      it "should be unsuccessful (unprocessable_entity)" do
        expect(response.status).to eql(422)
        expect(response.message).to eql("Unprocessable Entity")
      end

      it "should return a uniqueness validation error message" do
        expect(parsed_response[attribute_name.to_s]).to include("has already been taken")
      end
    end
  end
end
