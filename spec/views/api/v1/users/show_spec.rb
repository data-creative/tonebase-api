require "rails_helper"
require_relative "../../../../support/api/v1/view"

describe "api/v1/users/show.json.jbuilder" do
  before(:each) do
    assign(:user, create(:user) )
    render
  end

  it "displays a user" do
    expect(keys_of(parsed_view)).to match_array([
      :id, :email, :password, :confirmed, :visible, :role, :access_level,
      :first_name, :last_name, :bio, :image_url, :hero_url,
      :customer_uuid,
      :follows, :followers,
      :created_at, :updated_at
    ])
  end
end
