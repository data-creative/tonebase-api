class Api::V1::InstrumentsController < ApplicationController
  # @example GET /api/v1/instruments.json

  def index
    @response = {
      instruments: [
        {id: 1, name: "Guitar", description: "An instrument with six strings."}
      ]
    }

    respond_to do |format|
      format.json { render json: JSON.pretty_generate(@response) }
    end
  end
end
