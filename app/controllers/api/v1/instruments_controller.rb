class Api::V1::InstrumentsController < Api::V1::ApiController
  before_action :set_instrument, only: [:show, :update, :destroy]

  # GET /api/v1/instruments
  def index
    @instruments = Instrument.all
  end

  # GET /api/v1/instruments/:id
  def show
  end

  # POST /api/v1/instruments
  def create
    instrument = Instrument.new(instrument_params)
    save_and_render_json(instrument)
  end

  # PUT /api/v1/instruments/:id
  def update
    update_and_render_json(@instrument, instrument_params)
  end

  # DELETE /api/v1/instruments/:id
  def destroy
    destroy_and_render_json(@instrument)
  end

private

  def set_instrument
    @instrument = Instrument.find(params[:id])
  end

  def instrument_params
    params.require(:instrument).permit(:name, :description)
  end
end
