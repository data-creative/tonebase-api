require 'rails_helper'
require_relative '../../../support/api/v1/request'
require_relative '../../../support/api/v1/endpoints/index'
require_relative '../../../support/api/v1/endpoints/show'
require_relative '../../../support/api/v1/endpoints/create'
require_relative '../../../support/api/v1/endpoints/update'
require_relative '../../../support/api/v1/endpoints/destroy'

RSpec.describe Api::V1::VideosController, type: :controller do
  include_context "authenticate requests using valid token"

  describe "GET #index" do
    it_behaves_like "an index endpoint", Video
  end

  describe "GET #show" do
    it_behaves_like "a show endpoint", Video
  end

  describe "POST #create" do
    it_behaves_like "a create endpoint", Video  do
      let(:artist){ create(:artist) }
      let(:instrument){ create(:instrument) }
      let(:also_serialize){ [:video_parts_attributes, :video_scores_attributes] }
      let(:resource_params){
        {
          user_id: artist.id,
          instrument_id: instrument.id,
          title: "Finale from Sonata #99",
          description: "The final moments of master composer Maestrelli's most famous piece. Composed in 1817.",
          tags: ["borouque", "maestrelli", "g-major"],
          video_parts_attributes:[
            {source_url: "https://www.youtube.com/watch?v=abc123", number: 1, duration: 333},
            {source_url: "https://www.youtube.com/watch?v=def456", number: 2, duration: 333},
            {source_url: "https://www.youtube.com/watch?v=ghi789", number: 3, duration: 333}
          ],
          video_scores_attributes:[
            {image_url: "https://my-bucket.s3.amazonaws.com/my-dir/score-1-image.jpg", starts_at: 25, ends_at: 500},
            {image_url: "https://my-bucket.s3.amazonaws.com/my-dir/score-2-image.jpg", starts_at: 750, ends_at: 999}
          ]
        }
      }
    end

    it_behaves_like "a create endpoint which validates presence", Video, [:user, :instrument, :title, :description] do
      let(:resource_params){ {user_id: "", instrument_id: "", title:"", description:""} }
    end
  end

  describe "PUT #update" do
    it_behaves_like "an update endpoint", Video, {description: "My Revised Description."}
    it_behaves_like "an update endpoint which validates presence", Video, [:user, :instrument, :title, :description] do
      let(:resource_params){ {user_id: "", instrument_id: "", title:"", description:""} }
    end
  end

  describe "DELETE #destroy" do
    it_behaves_like "a destroy endpoint", Video
  end
end
