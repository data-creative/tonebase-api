require_relative "../../response"

# @param [Symbol] attribute_name The name of the search term.
# @param [String] invalid_search_term An invalid search term which should trigger a validation error.
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

      #context "when role=User" do
      #  let(:response){  get(:index, params: {format: 'json', role: "User"})  }
#
      #  it "filters only those users matching the given role" do
      #    expect(parsed_response.count).to eql(User.user.count)
      #  end
      #end

      #context "when role=Artist" do
      #  let(:response){  get(:index, params: {format: 'json', role: "Artist"})  }
#
      #  it "includes only those users matching the given role" do
      #    expect(parsed_response.count).to eql(User.artist.count)
      #  end
      #end

      #context "when role=Admin" do
      #  let(:response){  get(:index, params: {format: 'json', role: "Admin"})  }
#
      #  it "includes only those users matching the given role" do
      #    expect(parsed_response.count).to eql(User.admin.count)
      #  end
      #end
    end
  end
end
