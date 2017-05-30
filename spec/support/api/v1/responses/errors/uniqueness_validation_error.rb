require_relative "../../response"

shared_examples_for "a uniqueness validation error response" do |attribute_name|
  it "should return a uniqueness validation error message" do
    expect(parsed_response[attribute_name.to_s]).to include("has already been taken")
  end
end
