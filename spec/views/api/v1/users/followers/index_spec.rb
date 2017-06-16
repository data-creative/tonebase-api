require "rails_helper"
require_relative "../../../../../support/api/v1/view"

describe "api/v1/users/followers/index.json.jbuilder" do
  before(:each) do
    assign(:resources, [create(:user_followship), create(:user_followship)])
    render
  end

  it_behaves_like "an index view", 2, [
    :follower,
    :followed_at,
  ]
end
