require 'rails_helper'
require_relative '../../../support/api/v1/index'
require_relative '../../../support/api/v1/show'
require_relative '../../../support/api/v1/create'
require_relative '../../../support/api/v1/update'
require_relative '../../../support/api/v1/destroy'

RSpec.describe Api::V1::VideosController, type: :controller do
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
      let(:resource_params){
        {
          user_id: artist.id,
          instrument_id: instrument.id,
          title: "Finale from Sonata #99",
          description: "The final moments of master composer Maestrelli's most famous piece. Composed in 1817.",
          tags: ["borouque", "maestrelli", "g-major"]
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
