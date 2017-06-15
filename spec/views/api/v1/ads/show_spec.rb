require "rails_helper"
require_relative "../../../../support/api/v1/view"

describe "api/v1/ads/show.json.jbuilder" do
  before(:each) do
    assign(:ad, create(:ad, :with_instruments) )
    render
  end

  it "displays an ad" do
    expect(keys_of(parsed_view)).to match_array([:id, :advertiser, :title, :content, :url, :image_url, :instruments, :created_at, :updated_at])
  end

  it "displays associated advertiser" do
    expect(parsed_view["advertiser"].blank?).to be(false)
  end

  it "displays associated instrument(s)" do
    expect(parsed_view["instruments"].blank?).to be(false)
  end
end
