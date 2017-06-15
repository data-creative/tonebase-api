require 'rails_helper'
require_relative '../../../support/api/v1/request'
require_relative '../../../support/api/v1/endpoints/index'
require_relative '../../../support/api/v1/endpoints/create'
require_relative '../../../support/api/v1/endpoints/destroy'

RSpec.describe Api::V1::FollowsController, type: :controller do
  include_context "authenticate requests using valid token"

  describe "GET #index" do
    it_behaves_like "an index endpoint", UserFollowship
  end

  describe "DELETE #destroy" do
    it_behaves_like "a destroy endpoint", UserFollowship
  end
end
