require_relative "../../response"

shared_examples_for "a presence validation error response" do |attribute_name|
  it "should return a presence validation error message" do
    expect(parsed_response[attribute_name.to_s]).to include("can't be blank")
  end
end
