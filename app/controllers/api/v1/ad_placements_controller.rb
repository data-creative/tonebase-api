class Api::V1::AdPlacementsController < Api::V1::ApiController
  before_action :set_resource, only: [:show, :update, :destroy]

  # GET /api/v1/ad_placements
  def index
    @ad_placements = AdPlacement.all
  end

  # GET /api/v1/ad_placements/:id
  def show
  end

  # POST /api/v1/ad_placements
  def create
    ad_placement = AdPlacement.new(resource_params)
    save_and_render_json(ad_placement)
  end

  # PUT /api/v1/ad_placements/:id
  def update
    update_and_render_json(@ad_placement, resource_params)
  end

  # DELETE /api/v1/ad_placements/:id
  def destroy
    destroy_and_render_json(@ad_placement)
  end

private

  def set_resource
    @ad_placement = AdPlacement.find(params[:id])
  end

  def resource_params
    params.require(:ad_placement).permit(:ad_id, :start_date, :end_date, :price)
  end
end
