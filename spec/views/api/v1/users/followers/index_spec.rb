require "rails_helper"
require_relative "../../../../../support/api/v1/view"

describe "api/v1/users/followers/index.json.jbuilder" do
  before(:each) do
    assign(:resources, [create(:user_followship), create(:user_followship)])
    render
  end

  it "displays resources" do
    expect(parsed_view.count).to eql(2)
    parsed_view.each do |resource|
      expect(keys_of(resource)).to match_array([
        :follower,
        :followed_at,
      ])
    end
  end
end
