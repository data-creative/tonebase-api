class Api::V1::AdInstrumentsController < Api::V1::ApiController
  before_action :set_resource, only: [:destroy]

  # POST /api/v1/ad_instruments
  def create
    ad_instrument = AdInstrument.new(resource_params)
    save_and_render_json(ad_instrument)
  end

  # DELETE /api/v1/ad_instruments/:id
  def destroy
    destroy_and_render_json(@ad_instrument)
  end

private

  def set_resource
    @ad_instrument = AdInstrument.find(params[:id])
  end

  def resource_params
    params.require(:ad_instrument).permit(:ad_id, :instrument_id)
  end
end
