require "rails_helper"
require_relative "../../../../support/api/v1/view"

describe "api/v1/notifications/show.json.jbuilder" do
  before(:each) do
    assign(:notification, create(:notification) )
    render
  end

  it "displays a notification" do
    expect(keys_of(parsed_view)).to match_array([
      :id,
      :broadcastable_type,
      :broadcastable_id,
      :event,
      :headline,
      :url,
      :notified_users,
      :created_at,
      :updated_at
    ])
  end
end
