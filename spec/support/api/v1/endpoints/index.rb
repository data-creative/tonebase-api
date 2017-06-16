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

    context "with pagination params (page 1)" do
      let(:per_page){ 2 }
      let(:response){  get(:index, params: {page: 1, per_page: per_page, format: 'json'})  }

      it "should include at maximum the number of requested resources" do
        expect(parsed_response.count <= per_page).to eql(true)
      end

      it "should include the requested page of resources (in descending order of resource creation)" do
        requested_resources = model_class.first(per_page).map{|resource| resource["id"] } # note, resources sort in descending order by default, so calling .first(i) is really like calling .last(i).reverse
        resources = parsed_response.map{|resource| resource["id"] }
        expect(resources).to eql(requested_resources)
      end
    end
  end
end
