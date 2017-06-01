require "rails_helper"
require_relative "../../../../support/api/v1/view"

describe "api/v1/ads/show.json.jbuilder" do
  before(:each) do
    assign(:ad, create(:ad) )
    render
  end

  it "displays an ad" do
    expect(parsed_response.keys).to match_array([:id, :advertiser, :title, :content, :url, :image_url, :created_at, :updated_at])
  end

  it "displays a nested advertiser" do
    expect(parsed_response[:advertiser].keys).to match_array([:id, :name, :description, :url])
  end
end
