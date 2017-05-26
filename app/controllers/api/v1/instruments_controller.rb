class Api::V1::InstrumentsController < ApplicationController
  # @example GET /api/v1/instruments.json

  def index
    instruments = Instrument.all
    @response = {instruments: instruments.map{|instrument| instrument.as_json } }

    respond_to do |format|
      format.json { render json: JSON.pretty_generate(@response) }
    end
  end

  def show
    instrument = Instrument.find(params[:id])
    @response = {instrument: instrument.as_json}

    respond_to do |format|
      format.json { render json: JSON.pretty_generate(@response) }
    end
  end
end
