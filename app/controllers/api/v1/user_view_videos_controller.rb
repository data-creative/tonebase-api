class Api::V1::UserViewVideosController < Api::V1::ApiController
  # GET /api/v1/user_view_videos
  def index
    @user_view_videos = UserViewVideo.all
  end

  # POST /api/v1/user_view_videos
  def create
    resource = UserViewVideo.new(resource_params)
    save_and_render_json(resource)
  end

private

  def resource_params
    params.require(:user_view_video).permit(:user_id, :video_id)
  end
end
