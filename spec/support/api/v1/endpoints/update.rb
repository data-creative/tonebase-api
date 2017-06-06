require_relative '../response'
require_relative './update/presence_validation' # allows controller spec to avoid separately loading this file (for convenience and brevity)
require_relative './update/uniqueness_validation' # allows controller spec to avoid separately loading this file (for convenience and brevity)

shared_examples_for "an update endpoint" do |model_class, resource_params|
  let!(:resource) { create(model_class.name.underscore.to_sym) }

  describe "response" do
    context "with valid params" do
      let!(:response){ post(:update, params: {format: 'json', id: resource.id, model_class.name.underscore.to_sym => resource_params}) }

      it "should be successful (updated)" do
        expect(response.status).to eql(200)
        expect(response.message).to eql("OK")
      end

      it "should update the resource" do
        resource.reload
        expect(resource.serializable_hash.deep_symbolize_keys).to include(resource_params.deep_symbolize_keys)
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
