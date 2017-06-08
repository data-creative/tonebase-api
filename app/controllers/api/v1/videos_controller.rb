class Api::V1::VideosController < Api::V1::ApiController
  before_action :set_video, only: [:show, :update, :destroy]

  # GET /api/v1/videos
  def index
    @videos = Video.all
  end

  # GET /api/v1/videos/:id
  def show
  end

  # POST /api/v1/videos
  def create
    video = Video.new(video_params)
    save_and_render_json(video)
  end

  # PUT /api/v1/videos/:id
  def update
    update_and_render_json(@video, video_params)
  end

  # DELETE /api/v1/videos/:id
  def destroy
    destroy_and_render_json(@video)
  end

private

  def set_video
    @video = Video.find(params[:id])
  end

  def video_params
    params.require(:video).permit([
      :user_id, :instrument_id, :title, :description, tags: [],
      video_parts_attributes: [:source_url, :number, :duration],
      video_scores_attributes: [:image_url, :starts_at, :ends_at],
    ])
  end
end
