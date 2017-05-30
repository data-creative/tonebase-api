class Api::V1::InstrumentsController < Api::V1::ApiController
  before_action :set_instrument, only: [:show, :update, :destroy]

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
  # PUT /api/v1/instruments/:id
  #
  def update
    respond_to do |format|
      if @instrument.update(instrument_params)
        format.json { render json: @instrument, status: :ok}
      else
        format.json { render json: @instrument.errors, status: :unprocessable_entity }
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

  def set_instrument
    @instrument = Instrument.find(params[:id])
  end

  def instrument_params
    params.require(:instrument).permit(:name, :description)
  end
end
