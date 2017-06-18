require "rails_helper"
require_relative "../../../../support/api/v1/views/index"

describe "api/v1/videos/index.json.jbuilder" do
  before(:each) do
    assign(:resources, [create(:video), create(:video)])
    render
  end

  it_behaves_like "an index view", 2, [
    :id,
    :artist,
    :instrument,
    :title,
    :description,
    :tags,
    :parts,
    :scores,
    :favorited_by,
    :viewed_by,
    :created_at,
    :updated_at
  ]
end
