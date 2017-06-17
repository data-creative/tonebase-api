require "rails_helper"
require_relative "../../../../../support/api/v1/views/index"

describe "api/v1/users/follows/index.json.jbuilder" do
  before(:each) do
    assign(:resources, [create(:user_followship), create(:user_followship)])
    render
  end

  it_behaves_like "an index view", 2, [
    :id,
    :followed_user,
    :followed_at,
  ]
end
