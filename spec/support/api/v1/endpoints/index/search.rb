require_relative "../../response"

# @param [Symbol] attribute_name The name of the searchable attribute.
# @param [String] matching_value A matching value of the searchable attribute.
# @param [String] nonmatching_value A non-matching value of the searchable attribute.
# @param [String] matching_resources A list of resources which matches the search terms and should be included in the response.
# @example
#
#   it_behaves_like "an index endpoint which searches", :role, "User", "OOPS" do
#     let(:resources){ [create(:user), create(:user), create(:artist), create(:admin)] }
#     let(:matching_resources){ User.user }
#   end
#
shared_examples_for "an index endpoint which searches" do |attribute_name, matching_value, nonmatching_value|
  describe "response" do
    context "when a valid '#{attribute_name}' parameter is specified" do
      before(:each) do
        resources
      end

      context "when there are matching resources" do
        let(:response){ get(:index, params: {format: 'json', attribute_name.to_sym => matching_value}) }

        it "should be successful (ok) and return an array of matching resources" do
          expect(response.status).to eql(200)
          expect(parsed_response.count).to eql(matching_resources.count)
          expect(parsed_response.first[attribute_name.to_s]).to eql(matching_value)
        end
      end

      context "when there are no matching resources" do
        let(:response){ get(:index, params: {format: 'json', attribute_name.to_sym => nonmatching_value}) }

        it "should be successful (ok) and return an empty array" do
          expect(response.status).to eql(200)
          expect(parsed_response.empty?).to eql(true)
        end
      end
    end
  end
end
