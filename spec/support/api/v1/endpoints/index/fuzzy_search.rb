require_relative "../../response"

# @param [Symbol] attribute_name The name of the searchable attribute.
# @param [String] matching_value A matching value of the searchable attribute.
# @param [String] nonmatching_value A non-matching value of the searchable attribute.
# @param [String] matching_resources A list of resources which matches the search terms and should be included in the response.
# @example
#
#  it_behaves_like "an index endpoint which fuzzy searches", :email, "search4me", "OOPS" do
#    let(:email){ "search4me@gmail.com" }
#    let(:resources){ [create(:user), create(:user, email: email), create(:user)] }
#    let(:matching_resources){ User.where("email LIKE ?", email) }
#  end
#
shared_examples_for "an index endpoint which fuzzy searches" do |attribute_name, matching_value, nonmatching_value|
  describe "response" do
    context "when a valid '#{attribute_name}' parameter is specified" do
      before(:each) do
        resources
      end

      context "when there are matching resources" do
        let(:response){ get(:index, params: {format: 'json', attribute_name.to_sym => matching_value, fuzzy: true}) }

        it "should be successful (ok) and return an array of matching resources" do
          expect(response.status).to eql(200)
          expect(parsed_response.count).to eql(matching_resources.count)
          expect(parsed_response.first[attribute_name.to_s]).to eql(matching_value)
        end
      end

      context "when there are no matching resources" do
        let(:response){ get(:index, params: {format: 'json', attribute_name.to_sym => nonmatching_value, fuzzy: true}) }

        it "should be successful (ok) and return an empty array" do
          expect(response.status).to eql(200)
          expect(parsed_response.empty?).to eql(true)
        end
      end
    end
  end
end
