require "rails_helper"
require_relative "../../../../support/api/v1/view"

describe "api/v1/announcements/show.json.jbuilder" do
  before(:each) do
    assign(:announcement, create(:announcement) )
    render
  end

  it "displays an advertiser" do
    expect(keys_of(parsed_view)).to match_array([
      :id,
      :title,
      :content,
      :url,
      :image_url,
      :broadcast,
      :created_at,
      :updated_at
    ])
  end
end
