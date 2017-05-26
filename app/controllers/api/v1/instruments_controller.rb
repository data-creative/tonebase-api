class Api::V1::InstrumentsController < ApplicationController

  # GET /api/v1/instruments
  def index
    instruments = Instrument.all
    @response = {instruments: instruments.map{|instrument| instrument.as_json } }

    respond_to do |format|
      format.json { render json: JSON.pretty_generate(@response) }
    end
  end

  # GET /api/v1/instruments/:id
  def show
    instrument = Instrument.find(params[:id])
    @response = {instrument: instrument.as_json}

    respond_to do |format|
      format.json { render json: JSON.pretty_generate(@response) }
    end
  end

  # POST /api/v1/instruments
  def create
    @instrument = Instrument.new(instrument_params)

    @response = {instrument: @instrument.as_json}

    respond_to do |format|
      if @instrument.save
        format.json { render json: JSON.pretty_generate(@response), status: :created}
      else
        format.json { render json: @instrument.errors, status: :unprocessable_entity }
      end
    end
  end

  def instrument_params
    params.require(:instrument).permit(:name, :description)
  end
end
