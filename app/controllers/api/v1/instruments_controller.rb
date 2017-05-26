class Api::V1::InstrumentsController < ApplicationController

  # GET /api/v1/instruments
  def index
    instruments = Instrument.all

    respond_to do |format|
      format.json { render json: instruments }
    end
  end

  # GET /api/v1/instruments/:id
  def show
    instrument = Instrument.find(params[:id])

    respond_to do |format|
      format.json { render json: instrument }
    end
  end

  # POST /api/v1/instruments
  def create
    instrument = Instrument.new(instrument_params)

    respond_to do |format|
      if instrument.save
        format.json { render json: instrument, status: :created}
      else
        format.json { render json: instrument.errors, status: :unprocessable_entity }
      end
    end
  end

  def instrument_params
    params.require(:instrument).permit(:name, :description)
  end
end
