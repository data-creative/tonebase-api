require_relative "../../response"

shared_examples_for "a resource not found response" do
  it "should be unsuccessful (not_found)" do
    expect(response.status).to eql(404)
    expect(response.message).to eql("Not Found")
  end

  it "should return a 'not found' error message" do
    expect(parsed_response["id"]).to include("not found")
  end
end
