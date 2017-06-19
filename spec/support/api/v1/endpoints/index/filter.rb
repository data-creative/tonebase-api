require_relative "../../response"

# @param [Hash] search_params
# @param [Array<ApplicationRecord>] matching_resources Resources which match all the search terms.
# @param [Array<ApplicationRecord>] nonmatching_resources Resources which match none of the search terms.
# @param [Array<ApplicationRecord>, nil] partially_matching_resources Resources which match one but not all search terms.
# @example
#
shared_examples_for "an index endpoint which filters" do |model_class, request_params|
  describe "response" do
    let(:response){ get(:index, params: request_params.merge(format: 'json')) }

    before(:each) do
      matches
      nonmatches
    end

    it "should be successful (ok)" do
      expect(response.status).to eql(200)
    end

    it "should return an array of matching resources" do
      expect(parsed_response.count).to eql(matches.count)
    end

    it "should not return any other resources" do
      expect(defined?(matches).nil?).to eql(false) # expect to have been defined previously
      expect(defined?(nonmatches).nil?).to eql(false) # expect to have been defined previously
      expect(model_class.count).to eql(matches.count + nonmatches.count)
    end
  end
end
