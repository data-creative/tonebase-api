require "rails_helper"

describe "api/v1/ads/show.json.jbuilder" do
  it "displays an ad" do
    assign(:ad, create(:ad) )

    render

    expect(JSON.parse(rendered).keys).to match_array([
      "id",
      "advertiser",
      "title",
      "content",
      "url",
      "image_url",
      "created_at",
      "updated_at"
    ])
  end
end
