require "rails_helper"
require_relative "../../../../support/api/v1/views/index"

describe "api/v1/ads/index.json.jbuilder" do
  before(:each) do
    assign(:resources, [create(:ad), create(:ad)])
    render
  end

  it_behaves_like "an index view", 2, [
    :id,
    :advertiser,
    :title,
    :content,
    :url,
    :image_url,
    :instruments,
    :created_at,
    :updated_at
  ]
end
