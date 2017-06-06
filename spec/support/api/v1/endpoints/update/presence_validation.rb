require_relative "../../response"

# @param [ApplicationRecord] model_class
# @param [Array] attribute_names Contains symbols of all attribute names which should be validated for their presence.
# @param [Hash] resource_params For initializing the resource. Optionally pass this from inside a block so you can use other variables in its contstruction and generally be flexible.
# @example
#
#   it_behaves_like "an update endpoint which validates presence", Ad, [:title]
#
#   it_behaves_like "an update endpoint which validates presence", Ad, [:advertiser, :title]  do
#     let(:resource_params){ {advertiser_id: "", title: ""} }
#   end
##
shared_examples_for "an update endpoint which validates presence" do |model_class, attribute_names|
  let!(:resource) { create(model_class.name.underscore.to_sym) }

  if !defined?(resource_params)
    let(:resource_params){ compile_blank_params(attribute_names) }
  end

  describe "response" do
    context "with invalid params (blank attribute value)" do
      let!(:response){ post(:update, params: {format: 'json', id: resource.id, model_class.name.underscore.to_sym => resource_params}) }

      it "should be unsuccessful (unprocessable_entity)" do
        expect(response.status).to eql(422)
        expect(response.message).to eql("Unprocessable Entity")
      end

      it "should return a presence validation error message" do
        attribute_names.each do |attribute_name|
          expect(parsed_response[attribute_name.to_s]).to include("can't be blank")
        end
      end
    end
  end
end
