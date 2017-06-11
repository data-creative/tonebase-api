require 'rails_helper'
require_relative '../../../support/api/v1/request'
require_relative '../../../support/api/v1/endpoints/update'

RSpec.describe Api::V1::UserNotificationsController, type: :controller do
  include_context "authenticate requests using valid token"

  describe "PUT #update" do
    it_behaves_like "an update endpoint", UserNotification, {marked_read: true}

    it_behaves_like "an update endpoint which validates presence", UserNotification, [:user, :notification] do
      let(:resource_params){ {user_id: nil, notification_id: nil} }
    end
  end
end
