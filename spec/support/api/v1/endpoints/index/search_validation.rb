require_relative "../../response"

# @deprecated because we no longer want to do a pre-check to validate user roles before trying to find matches. the client app is smart enough to not need such a validation.
# @param [Symbol] attribute_name The name of the searchable attribute.
# @param [String] invalid_search_term An invalid value of the searchable attribute which should trigger a validation error.
# @example
#
#  it_behaves_like "an index endpoint which validates search", :role, "OOPS"
#
shared_examples_for "an index endpoint which validates search" do |attribute_name, invalid_search_term|
  describe "response" do
    context "when a '#{attribute_name}' parameter is specified" do

      context "when #{attribute_name} is invalid" do
        let(:response){  get(:index, params: {format: 'json', attribute_name.to_sym => invalid_search_term})  }

        it "returns an error" do
          expect(response.code).to eql("404")
          expect(parsed_response[attribute_name.to_s]).to include("not found")
        end
      end
    end
  end
end
