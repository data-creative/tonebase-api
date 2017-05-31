require_relative "./response"
require_relative './create/presence_validation'
require_relative './create/uniqueness_validation'

shared_examples_for "a create endpoint" do |model_class, resource_params|
  let!(:resource) { create(model_class.name.downcase.to_sym) }

  describe "response" do
    context "with valid params" do
      let(:response){ post(:create, params: {format: 'json', model_class.name.downcase.to_sym => resource_params}) }

      it "should be successful (created)" do
        expect(response.status).to eql(201)
        expect(response.message).to eql("Created")
      end

      it "should create a new resource" do
        expect{response}.to change{model_class.count}.by(1)
      end
    end
  end
end
