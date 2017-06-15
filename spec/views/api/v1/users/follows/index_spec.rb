require "rails_helper"
require_relative "../../../../../support/api/v1/view"

describe "api/v1/users/follows/index.json.jbuilder" do
  before(:each) do
    assign(:user_followships, [create(:user_followship), create(:user_followship)])
    render
  end

  it "displays user followships" do
    expect(parsed_view.count).to eql(2)
    parsed_view.each do |resource|
      expect(keys_of(resource)).to match_array([
        :id,
        :user_id,
        :followed_user_id,
        :created_at,
        :updated_at
      ])
    end
  end
end
