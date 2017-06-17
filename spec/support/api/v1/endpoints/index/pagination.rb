require_relative "../../response"

shared_examples_for "an index endpoint which paginates" do |model_class|
  describe "response" do
    before(:each) do
      10.times do
        create(model_class.name.underscore.to_sym)
      end
    end

    context "with invalid pagination params (missing 'per_page')" do
      let(:response){  get(:index, params: {page: 1, format: 'json'})  }

      it "should be unsuccessful (bad_request)" do
        expect(response.status).to eql(400)
      end

      it "should include a helpful error message" do
        expect(parsed_response["pagination"]).to include("when supplying pagination parameters, please use both 'page' and 'per_page'")
      end
    end

    context "with invalid pagination params (missing 'page')" do
      let(:response){  get(:index, params: {per_page: 10, format: 'json'})  }

      it "should be unsuccessful (bad_request)" do
        expect(response.status).to eql(400)
      end

      it "should include a helpful error message" do
        expect(parsed_response["pagination"]).to include("when supplying pagination parameters, please use both 'page' and 'per_page'")
      end
    end

    context "with pagination params (page 1)" do
      let(:per_page){ 5 }
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

    context "with pagination params (subsequent pages)" do
      let(:per_page){ 5 }
      let(:page){ 2 }
      let(:response){  get(:index, params: {page: page, per_page: per_page, format: 'json'})  }

      it "should include at maximum the number of requested resources" do
        expect(parsed_response.count <= per_page).to eql(true)
      end

      it "should include the requested page of resources (in descending order of resource creation)" do
        requested_resources = model_class.first(page * per_page).last(per_page).map{|resource| resource["id"] } # note, resources sort in descending order by default, so calling .first(i) is really like calling .last(i).reverse
        resources = parsed_response.map{|resource| resource["id"] }
        expect(resources).to eql(requested_resources)
      end
    end
  end
end
