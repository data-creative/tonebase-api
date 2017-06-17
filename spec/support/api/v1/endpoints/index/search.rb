require_relative "../../response"

# @param [Symbol] attribute_name The name of the searchable attribute.
# @param [String] valid_search_term A valid value of the searchable attribute.
# @param [String] matching_resources A list of resources which matches the search terms and should be included in the response.
# @example
#
#   it_behaves_like "an index endpoint which searches", :role, "User" do
#     let!(:resources){ [create(:user), create(:user), create(:artist), create(:admin)] }
#     let(:matching_resources){ User.user }
#   end
#
shared_examples_for "an index endpoint which searches" do |attribute_name, valid_search_term|
  describe "response" do
    context "when a '#{attribute_name}' parameter is specified" do

      context "when #{attribute_name}=#{valid_search_term}" do
        let(:response){ get(:index, params: {format: 'json', attribute_name.to_sym => valid_search_term}) }

        it "returns only those resources which match the search term" do
          expect(parsed_response.count).to eql(matching_resources.count)
        end
      end
    end
  end
end
