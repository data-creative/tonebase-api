require "rails_helper"
require_relative "../../../../support/api/v1/views/index"

describe "api/v1/ad_placements/index.json.jbuilder" do
  before(:each) do
    assign(:resources, create(:ad, :with_placements).placements)
    render
  end

  it_behaves_like "an index view", 3, [
    :id,
    :ad,
    :start_date,
    :end_date,
    :price,
    :created_at,
    :updated_at
  ]
end
