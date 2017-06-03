require "rails_helper"
require_relative "../../../../support/api/v1/view"

describe "api/v1/users/index.json.jbuilder" do
  before(:each) do
    #assign(:users, [create(:user), create(:user), create(:artist), create(:admin)])
    assign(:users, [create(:user), create(:user)]) # use this instead of the line above because the role-filtering that happens in the controller is not relevant here
    render
  end

  it "displays users" do
    expect(parsed_view.count).to eql(2)
    parsed_view.each do |user|
      expect(keys_of(user)).to match_array([
        :id, :email, :password, :confirmed, :visible, :role, :access_level,
        :first_name, :last_name, :bio, :image_url, :hero_url,
        :followers,
        :created_at, :updated_at
      ])
    end
  end
end
