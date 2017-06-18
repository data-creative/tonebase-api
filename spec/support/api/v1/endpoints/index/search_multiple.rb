require_relative "../../response"

# @param [Hash] search_params
# @param [Array<ApplicationRecord>] matching_resources Resources which match all the search terms.
# @param [Array<ApplicationRecord>] partially_matching_resources Resources which match one but not all search terms.
# @param [Array<ApplicationRecord>] nonmatching_resources Resources which match none of the search terms.
# @example
#
#   it_behaves_like "an index endpoint which searches multiple terms" do
#     let(:search_params){ {role: "User", access_level: "Full"} }
#     let(:matching_resources){ create_list(:full_access_user, 3) }
#     let(:partially_matching_resources){ create_list(:limited_access_user, 3) }
#     let(:nonmatching_resources){ create_list(:artist, 3) }
#   end
#
shared_examples_for "an index endpoint which searches multiple terms" do
  describe "response" do
    context "with multiple search terms" do
      let(:response){ get(:index, params: search_params.merge(format: 'json')) }

      context "when there are resources matching all terms" do
        before(:each) do
          matching_resources
        end

        it "should be successful (ok) and return an array of matching resources" do
          expect(response.status).to eql(200)
          expect(parsed_response.count).to eql(matching_resources.count)
        end
      end

      context "when there are resources matching some but not all of the terms" do
        before(:each) do
          partially_matching_resources
        end

        it "should be successful (ok) and return an empty array" do
          expect(response.status).to eql(200)
          expect(parsed_response.empty?).to eql(true)
        end
      end

      context "when there are no resources which match all the terms" do
        before(:each) do
          nonmatching_resources
        end

        it "should be successful (ok) and return an empty array" do
          expect(response.status).to eql(200)
          expect(parsed_response.empty?).to eql(true)
        end
      end
    end
  end
end
