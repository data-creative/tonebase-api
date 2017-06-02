require_relative "../view"

# @param [Integer] resource_count
# @param [Array] attributes
shared_examples_for "an index view" do |resource_count, attributes|
  it "displays resources" do
    expect(parsed_view.count).to eql(resource_count)

    parsed_view.each do |resource|
      expect(keys_of(resource)).to match_array(attributes)
    end
  end
end
