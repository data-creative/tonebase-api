require_relative "../response"

# @param [ApplicationRecord] model_class
# @param [Array] attribute_names Contains symbols of all attribute names which should be validated for their uniqueness.
# @param [Hash] resource_params For initializing the resource. Pass this from inside a block so you can use other variables in its contstruction.
# @example
#
#   it_behaves_like "a create endpoint which validates uniqueness", Ad, [:title]  do
#     let!(:advertiser){ create(:advertiser)}
#     let!(:other_ad){ create(:ad)}
#     let(:resource_params){ {advertiser_id: advertiser.id, title: other_ad.title} }
#   end
#
shared_examples_for "a create endpoint which validates uniqueness" do |model_class, attribute_names|
  describe "response" do
    context "with invalid params (duplicate attribute value)" do
      let(:response){ post(:create, params: {format: 'json', model_class.name.downcase.to_sym => resource_params}) }

      it "should be unsuccessful (unprocessable_entity)" do
        expect(response.status).to eql(422)
        expect(response.message).to eql("Unprocessable Entity")
      end

      it "should return a uniqueness validation error message" do
        attribute_names.each do |attribute_name|
          expect(parsed_response[attribute_name.to_s]).to include("has already been taken")
        end
      end

      it "should not create a resource" do
        expect{response}.to change{model_class.count}.by(0)
      end
    end
  end
end
