class Api::V1::Ads::InstrumentsController < Api::V1::ApiController
  before_action :set_resource, only: [:destroy]

  # DELETE /api/v1/ads/:ad_id/instruments/:instrument_id
  def destroy
    destroy_and_render_json(@ad_instrument)
  end

private

  def set_resource
    @ad_instrument = AdInstrument.where(resource_params).first
    render_404 unless @ad_instrument
  end

  def resource_params
    params.permit(:ad_id, :instrument_id)
  end
end
