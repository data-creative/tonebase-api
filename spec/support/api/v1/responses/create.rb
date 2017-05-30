require_relative "./errors/presence_validation_error"
require_relative "./errors/uniqueness_validation_error"
require_relative "./errors/unprocessable"

shared_examples_for "a successful resource creation response" do |model_class|
  it "should be successful (created)" do
    expect(response.status).to eql(201)
    expect(response.message).to eql("Created")
  end

  it "should create a new resource" do
    expect{response}.to change{model_class.count}.by(1)
  end
end
