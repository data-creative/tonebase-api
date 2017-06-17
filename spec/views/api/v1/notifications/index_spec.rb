require "rails_helper"
require_relative "../../../../support/api/v1/views/index"

describe "api/v1/notifications/index.json.jbuilder" do
  before(:each) do
    assign(:resources, [create(:notification), create(:notification)])
    render
  end

  it_behaves_like "an index view", 2, [
    :id,
    :broadcastable_type,
    :broadcastable_id,
    :event,
    :headline,
    :url,
    :notified_users,
    :created_at,
    :updated_at
  ]
end
