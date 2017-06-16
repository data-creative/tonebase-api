require "rails_helper"
require_relative "../../../../support/api/v1/view"

describe "api/v1/announcements/index.json.jbuilder" do
  before(:each) do
    assign(:resources, [create(:announcement), create(:announcement)])
    render
  end

  it_behaves_like "an index view", 2, [
    :id,
    :title,
    :content,
    :url,
    :image_url,
    :broadcast,
    :created_at,
    :updated_at
  ]
end
