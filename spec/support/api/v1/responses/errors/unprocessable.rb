shared_examples_for "an unprocessable resource response" do
  it "should be unsuccessful (unprocessable_entity)" do
    expect(response.status).to eql(422)
    expect(response.message).to eql("Unprocessable Entity")
  end
end
