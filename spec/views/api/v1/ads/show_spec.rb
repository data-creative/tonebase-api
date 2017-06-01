require "rails_helper"
require_relative "../../../../support/api/v1/view"

describe "api/v1/ads/show.json.jbuilder" do
  before(:each) do
    assign(:ad, create(:ad) )
    render
  end

  it "displays an ad with nested advertiser" do
    expect(keys_of(parsed_view)).to match_array([:id, :advertiser, :title, :content, :url, :image_url, :created_at, :updated_at])
  end
end
