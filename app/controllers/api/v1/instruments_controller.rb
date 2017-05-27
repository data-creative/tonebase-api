class Api::V1::InstrumentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  before_action :set_instrument, only: [:show, :destroy]

  #
  # GET /api/v1/instruments
  #
  def index
    instruments = Instrument.all

    respond_to do |format|
      format.json { render json: instruments }
    end
  end

  #
  # GET /api/v1/instruments/:id
  #
  def show
    respond_to do |format|
      format.json { render json: @instrument }
    end
  end

  #
  # POST /api/v1/instruments
  #
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

  #
  # DELETE /api/v1/instruments/:id
  #
  def destroy
    @instrument.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

private

  def render_404
    render json: {"id": ["not found"]}, status: :not_found
  end

  def set_instrument
    @instrument = Instrument.find(params[:id])
  end

  def instrument_params
    params.require(:instrument).permit(:name, :description)
  end
end
