require_relative "./errors/not_found"
require_relative "./errors/presence_validation_error"
require_relative "./errors/uniqueness_validation_error"
require_relative "./errors/unprocessable"

shared_examples_for "a successful resource update response" do
  it "should be successful (updated)" do
    expect(response.status).to eql(200)
    expect(response.message).to eql("OK")
  end
end
