require 'rails_helper'
require_relative '../../../support/api/v1/request'
require_relative '../../../support/api/v1/endpoints/index'
require_relative '../../../support/api/v1/endpoints/show'
require_relative '../../../support/api/v1/endpoints/destroy'

RSpec.describe Api::V1::NotificationsController, type: :controller do
  include_context "authenticate requests using valid token"

  describe "GET #index" do
    it_behaves_like "an index endpoint", Notification
  end

  describe "GET #show" do
    it_behaves_like "a show endpoint", Notification
  end

  describe "DELETE #destroy" do
    it_behaves_like "a destroy endpoint", Notification
  end
end
