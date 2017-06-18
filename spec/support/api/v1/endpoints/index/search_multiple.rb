require_relative "../../response"

shared_examples_for "an index endpoint which searches multiple terms" do
  describe "response" do
    context "with multiple search terms" do
      context "when there are resources matching all terms" do
        let(:response){ get(:index, params: search_params) }

        it "should be successful (ok) and return an array of matching resources" do
          expect(response.status).to eql(200)
          expect(parsed_response.count).to eql(matching_resources.count)
          expect(parsed_response.first[attribute_name.to_s]).to eql(matching_value)
        end
      end

      #context "when there are resources matching some but not all of the terms" do
      #  it "should be successful (ok) and return an empty array" do
      #    expect(response.status).to eql(200)
      #    expect(parsed_response.empty?).to eql(true)
      #  end
      #end

      #context "when there are no resources which match all the terms" do
      #  it "should be successful (ok) and return an empty array" do
      #    expect(response.status).to eql(200)
      #    expect(parsed_response.empty?).to eql(true)
      #  end
      #end
    end
  end
end
