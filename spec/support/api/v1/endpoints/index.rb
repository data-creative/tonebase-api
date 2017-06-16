require_relative "../response"

shared_examples_for "an index endpoint" do |model_class|
  let!(:resource) { create(model_class.name.underscore.to_sym) }

  describe "response" do
    context "when successful" do
      let(:response){  get(:index, params: {format: 'json'})  }

      it "should be successful (ok)" do
        expect(response.status).to eql(200)
      end

      it "should be an array" do
        expect(parsed_response).to be_kind_of(Array)
      end

      it "should include all resources" do
        expect(parsed_response.count).to eql(model_class.count)
        expect(parsed_response.any?).to be true
      end
    end
  end
end
