class Api::V1::AdsController < Api::V1::ApiController
  before_action :set_ad, only: [:show, :update, :destroy]

  # GET /api/v1/ads
  def index
    @ads = Ad.all
  end

  # GET /api/v1/ads/:id
  def show
  end

  # POST /api/v1/ads
  def create
    ad = Ad.new(ad_params)
    save_and_render_json(ad)
  end

  # PUT /api/v1/ads/:id
  def update
    update_and_render_json(@ad, ad_params)
  end

  # DELETE /api/v1/ads/:id
  def destroy
    destroy_and_render_json(@ad)
  end

private

  def set_ad
    @ad = Ad.find(params[:id])
  end

  def ad_params
    params.require(:ad).permit(:advertiser_id, :title, :content, :url, :image_url)
  end
end
