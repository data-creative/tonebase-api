require_relative "../response"

shared_examples_for "an index endpoint" do |model_class|
  describe "response" do
    before(:each) do
      10.times do
        create(model_class.name.underscore.to_sym)
      end
    end

    context "without params" do
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

    context "with pagination params" do
      context "with limit" do
        let(:limit){ 2 }
        let(:response){  get(:index, params: {limit: limit, format: 'json'})  }

        it "should be successful (ok)" do
          expect(response.status).to eql(200)
        end

        it "should be an array" do
          expect(parsed_response).to be_kind_of(Array)
        end

        it "should include only the requested resources" do
          expect(parsed_response.any?).to be true
          expect(parsed_response.count).to eql(limit)
        end
      end

      #context "with offset" do
      #end
    end
  end
end
