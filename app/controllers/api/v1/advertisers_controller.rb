class Api::V1::AdvertisersController < Api::V1::ApiController
  before_action :set_advertiser, only: [:show, :update, :destroy]

  #
  # GET /api/v1/advertisers
  #
  def index
    advertisers = Advertiser.all

    respond_to do |format|
      format.json { render json: advertisers }
    end
  end

  #
  # GET /api/v1/advertisers/:id
  #
  def show
    respond_to do |format|
      format.json { render json: @advertiser }
    end
  end

  #
  # POST /api/v1/advertisers
  #
  def create
    advertiser = Advertiser.new(advertiser_params)

    respond_to do |format|
      if advertiser.save
        format.json { render json: advertiser, status: :created}
      else
        format.json { render json: advertiser.errors, status: :unprocessable_entity }
      end
    end
  end

  #
  # PUT /api/v1/advertisers/:id
  #
  def update
    respond_to do |format|
      if @advertiser.update(advertiser_params)
        format.json { render json: @advertiser, status: :ok}
      else
        format.json { render json: @advertiser.errors, status: :unprocessable_entity }
      end
    end
  end

  #
  # DELETE /api/v1/advertisers/:id
  #
  def destroy
    @advertiser.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

private

  def set_advertiser
    @advertiser = Advertiser.find(params[:id])
  end

  def advertiser_params
    my_params = params.require(:advertiser).permit(:name, :description, :url)
    # workaround to allow unstructured object passed via params ...
    my_params[:metadata] = params[:advertiser][:metadata]
    my_params.permit!
  end
end
