require 'rails_helper'

require_relative '../../../support/api/v1/index'
require_relative '../../../support/api/v1/show'
require_relative '../../../support/api/v1/create'
require_relative '../../../support/api/v1/create/presence_validation'
require_relative '../../../support/api/v1/create/uniqueness_validation'
require_relative '../../../support/api/v1/update'
require_relative '../../../support/api/v1/update/presence_validation'
require_relative '../../../support/api/v1/update/uniqueness_validation'
require_relative '../../../support/api/v1/destroy'

RSpec.describe Api::V1::InstrumentsController, type: :controller do
  describe "GET #index" do
    it_behaves_like "an index", Instrument, :name
  end

  describe "GET #show" do
    it_behaves_like "a show endpoint", Instrument, :name
  end

  describe "POST #create" do
    it_behaves_like "a create endpoint", Instrument, {name: "Tambourine", description: "Shake it."}
    it_behaves_like "a create endpoint which validates presence", Instrument, :name
    it_behaves_like "a create endpoint which validates uniqueness", Instrument, :name
  end

  describe "PUT #update" do
    it_behaves_like "an update endpoint", Instrument, {description: "Shake it some more."}
    it_behaves_like "an update endpoint which validates presence", Instrument, :name
    it_behaves_like "an update endpoint which validates uniqueness", Instrument, :name
  end

  describe "DELETE #destroy" do
    it_behaves_like "a destroy endpoint", Instrument
  end
end
