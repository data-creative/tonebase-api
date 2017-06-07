require_relative "../../response"

# @param [ApplicationRecord] model_class
# @param [Array] attribute_names Contains symbols of all attribute names which should be validated for their uniqueness.
# @param [Hash] resource_params For initializing the resource. Pass this from inside a block so you can use other variables in its contstruction.
# @example
#
#   it_behaves_like "an update endpoint which validates uniqueness", User, [:email, :username]  do
#     let!(:other_user){ create(:user)}
#     let(:resource_params){ {email: other_user.email, username: other_user.username} }
#   end
#
shared_examples_for "an update endpoint which validates uniqueness" do |model_class, attribute_names|
  let!(:resource) { create(model_class.name.underscore.to_sym) }

  describe "response" do
    context "with invalid params (duplicate attribute value)" do
      let(:response){ post(:update, params: {format: 'json', id: resource.id, model_class.name.underscore.to_sym => resource_params}) }

      it "should be unsuccessful (unprocessable_entity)" do
        expect(response.status).to eql(422)
        expect(response.message).to eql("Unprocessable Entity")
      end

      it "should return a uniqueness validation error message" do
        attribute_names.each do |attribute_name|
          expect(parsed_response[attribute_name.to_s]).to include("has already been taken")
        end
      end
    end
  end
end
