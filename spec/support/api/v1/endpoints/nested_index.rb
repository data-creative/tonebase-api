require_relative "../response"
require_relative './nested_index/pagination' # allows controller spec to avoid separately loading this file (for convenience and brevity)

# @param [ApplicationRecord] resource The parent resource.
# @param [Array] nested_resources A list of associated child resources.
# @param [Symbol] resource_id_attribute
# @example GET /api/v1/users/:user_id/followers
#
#   it_behaves_like "a nested index endpoint", :user_id do
#     let(:resource){ create(:artist, :with_followers) }
#     let(:nested_resources){ resource.followers }
#   end
#
shared_examples_for "a nested index endpoint" do |resource_id_attribute|
  describe "response" do
    context "with valid params" do
      let(:response){ get(:index, params: {resource_id_attribute => resource.id, format: 'json'}) }

      it "should be successful (ok)" do
        expect(response.status).to eql(200)
      end

      it "should be an array" do
        expect(parsed_response).to be_kind_of(Array)
      end

      it "should include nested resources" do
        expect(parsed_response.count).to eql(nested_resources.count)
        expect(parsed_response.any?).to be true
      end
    end

    context "with invalid params (wrong resource id)" do
      let(:response){ get(:index, params: {resource_id_attribute => "OOPS", format: 'json'}) }

      it "should be unsuccessful (not_found)" do
        expect(response.status).to eql(404)
        expect(response.message).to eql("Not Found")
      end

      it "should return a 'not found' error message" do
        expect(parsed_response["id"]).to include("not found")
      end
    end
  end
end
