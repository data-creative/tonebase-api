require_relative "../response"
require_relative "./errors/not_found"

shared_examples_for "a successful show response" do
  it "should be successful (ok)" do
    expect(response.status).to eql(200)
  end

  it "should return an object" do
    expect(parsed_response).to be_kind_of(Hash)
  end
end
