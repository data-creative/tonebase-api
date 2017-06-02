require_relative "../view"

# @param [Array] attributes
shared_examples_for "a show view" do |attributes|
  it "displays a resource" do
    expect(keys_of(parsed_view)).to match_array(attributes)
  end
end
