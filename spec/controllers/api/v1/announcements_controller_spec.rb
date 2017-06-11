require 'rails_helper'
require_relative '../../../support/api/v1/request'
require_relative '../../../support/api/v1/endpoints/index'
require_relative '../../../support/api/v1/endpoints/show'
require_relative '../../../support/api/v1/endpoints/create'
require_relative '../../../support/api/v1/endpoints/update'
require_relative '../../../support/api/v1/endpoints/destroy'

RSpec.describe Api::V1::AnnouncementsController, type: :controller do
  include_context "authenticate requests using valid token"

  describe "GET #index" do
    it_behaves_like "an index endpoint", Announcement
  end

  describe "GET #show" do
    it_behaves_like "a show endpoint", Announcement
  end

  describe "POST #create" do
    it_behaves_like "a create endpoint", Announcement do
      let(:resource_params){
        {
          title: "New Feature ABC",
          content: "This new feature allows you to do cool things.",
          url: "https://blog.tonebase.com/posts/new-feature-abc",
          image_url: "https://my-bucket.s3.amazonaws.com/my-dir/my-image.jpg",
          broadcast: false
        }
      }
    end

    it_behaves_like "a create endpoint which validates presence", Announcement, [:title]

    it_behaves_like "a create endpoint which validates uniqueness", Announcement, [:title] do
      let!(:other_announcement){ create(:announcement) }
      let(:resource_params){ {title: other_announcement.title} }
    end
  end

  describe "PUT #update" do
    it_behaves_like "an update endpoint", Announcement, {content: "EDITS EDITS EDITS"}

    it_behaves_like "an update endpoint which validates presence", Announcement, [:title]

    it_behaves_like "an update endpoint which validates uniqueness", Announcement, [:title] do
      let!(:other_announcement){ create(:announcement) }
      let(:resource_params){ {title: other_announcement.title} }
    end
  end

  describe "DELETE #destroy" do
    it_behaves_like "a destroy endpoint", Announcement
  end
end
