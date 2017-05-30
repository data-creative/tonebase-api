require_relative "./errors/not_found"

shared_examples_for "a successful resource destruction response" do |model_class|
  it "should be successful (destroyed)" do
    expect(response.status).to eql(204)
    expect(response.message).to eql("No Content")
  end

  it "should create a new resource" do
    expect{response}.to change{model_class.count}.by(-1)
  end
end
