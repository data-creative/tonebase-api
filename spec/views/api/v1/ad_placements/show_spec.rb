require "rails_helper"
require_relative "../../../../support/api/v1/views/show"

describe "api/v1/ad_placements/show.json.jbuilder" do
  before(:each) do
    assign(:ad_placement, create(:ad_placement) )
    render
  end

  it_behaves_like "a show view", [:id, :ad, :start_date, :end_date, :price, :created_at, :updated_at]
end
