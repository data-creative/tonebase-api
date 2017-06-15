require_relative "../response"

# @param [ApplicationRecord] resource
# @param [Array] nested_resources
# @param [Hash] request_params
# @example GET /api/v1/users/:user_id/followers
#
#   it_behaves_like "a nested index endpoint" do
#     let(:resource){ create(:artist, :with_followers) }
#     let(:nested_resources){ resource.followers }
#     let(:request_params){ {user_id: resource.id} }
#   end
#
shared_examples_for "a nested index endpoint" do
  describe "response" do
    context "when successful" do
      let(:response){ get(:index, params: request_params.merge({format: 'json'})) }

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
  end
end
