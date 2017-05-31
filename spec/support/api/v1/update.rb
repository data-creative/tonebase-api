require_relative "./response"
require_relative './update/presence_validation'
require_relative './update/uniqueness_validation'

shared_examples_for "an update endpoint" do |model_class, resource_params|
  let!(:resource) { create(model_class.name.downcase.to_sym) }

  describe "response" do
    context "with valid params" do
      let!(:response){ post(:update, params: {format: 'json', id: resource.id, model_class.name.downcase.to_sym => resource_params}) }

      it "should be successful (updated)" do
        expect(response.status).to eql(200)
        expect(response.message).to eql("OK")
      end

      it "should update the resource" do
        resource.reload
        expect(resource.serializable_hash.deep_symbolize_keys).to include(resource_params.deep_symbolize_keys)
      end
    end
  end
end
