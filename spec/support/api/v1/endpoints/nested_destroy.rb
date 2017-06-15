require_relative "../response"

# @param [Class] model_class The class of object that should be deleted.
# @param [ApplicationRecord] resource The parent resource.
# @param [Array] nested_resource A child resources.
# @param [Symbol] resource_id_attribute The parent resource parameter name.
# @param [Symbol] nested_resource_id_attribute The child resource parameter name.
# @example DELETE /api/v1/users/:user_id/follows/:followed_user_id
#
#   it_behaves_like "a nested destroy endpoint", UserFollowship, :user_id, :followed_user_id do
#     let!(:resource){ create(:user, :follower) }
#     let(:nested_resource){ resource.follows.first }
#   end
#
shared_examples_for "a nested destroy endpoint" do |model_class, resource_id_attribute, nested_resource_id_attribute|
  describe "response" do
    context "with valid params" do
      let(:response){
        delete(:destroy, params: {
          resource_id_attribute => resource.id,
          nested_resource_id_attribute => nested_resource.id,
          format: 'json'
        })
      }

      it "should be successful (destroyed)" do
        expect(response.status).to eql(204)
        expect(response.message).to eql("No Content")
      end

      it "should destroy the specified resource" do
        expect{response}.to change{model_class.count}.by(-1)
      end
    end

    context "with invalid params (wrong resource id)" do
      let(:response){
        delete(:destroy, params: {
          resource_id_attribute => "OOPS",
          nested_resource_id_attribute => nested_resource.id,
          format: 'json'
        })
      }

      it "should be unsuccessful (not_found)" do
        expect(response.status).to eql(404)
        expect(response.message).to eql("Not Found")
      end

      it "should return a 'not found' error message" do
        expect(parsed_response["id"]).to include("not found")
      end

      it "should not destroy anything" do
        expect{response}.to change{model_class.count}.by(0)
      end
    end

    context "with invalid params (wrong nested resource id)" do
      let(:response){
        delete(:destroy, params: {
          resource_id_attribute => resource.id,
          nested_resource_id_attribute => "OOPS",
          format: 'json'
        })
      }

      it "should be unsuccessful (not_found)" do
        expect(response.status).to eql(404)
        expect(response.message).to eql("Not Found")
      end

      it "should return a 'not found' error message" do
        expect(parsed_response["id"]).to include("not found")
      end

      it "should not destroy anything" do
        expect{response}.to change{model_class.count}.by(0)
      end
    end
  end
end
