require "rails_helper"
require_relative "../../../../support/api/v1/view"

describe "api/v1/metrics/users_over_time.json.jbuilder" do
  before(:each) do
    assign(:users, [ create(:limited_access_user), create(:full_access_user), create(:artist), create(:admin) ])
    render
  end

  it "displays user registrations" do
    expect(parsed_view.count).to eql(4)
    parsed_view.each do |user|
      expect(keys_of(user)).to match_array([
        :user_id,
        :registered_at,
        :current_role,
        :current_access_level
      ])
    end
  end
end
