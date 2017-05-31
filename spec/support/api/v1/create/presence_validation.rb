require_relative "../response"

# @param [ApplicationRecord] model_class
# @param [Array] attribute_names Contains symbols of all attribute names which should be validated for their presence.
# @param [Hash] resource_params For initializing the resource. Pass this from inside a block so you can use other variables in its contstruction.
# @example
#
#   it_behaves_like "a create endpoint which validates presence", Ad, [:title]  do
#     let(:advertiser){ create(:advertiser)}
#     let(:resource_params){ {advertiser_id: advertiser.id, title: ""} }
#   end
#
shared_examples_for "a create endpoint which validates presence" do |model_class, attribute_names|
  describe "response" do
    context "with invalid params (blank attribute value)" do
      let(:response){ post(:create, params: {format: 'json', model_class.name.downcase.to_sym => resource_params}) }

      it "should be unsuccessful (unprocessable_entity)" do
        expect(response.status).to eql(422)
        expect(response.message).to eql("Unprocessable Entity")
      end

      it "should return a presence validation error message" do
        attribute_names.each do |attribute_name|
          expect(parsed_response[attribute_name.to_s]).to include("can't be blank")
        end
      end

      it "should not create a resource" do
        expect{response}.to change{model_class.count}.by(0)
      end
    end
  end
end
