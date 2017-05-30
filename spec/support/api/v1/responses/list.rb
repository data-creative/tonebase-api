require_relative "../response"

shared_examples_for "a list response" do
  it "should be successful (ok)" do
    expect(response.status).to eql(200)
  end

  it "should be an array" do
    expect(parsed_response).to be_kind_of(Array)
  end
end
