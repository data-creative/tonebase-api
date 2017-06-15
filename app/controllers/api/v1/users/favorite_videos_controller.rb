class Api::V1::Users::FavoriteVideosController < Api::V1::ApiController
  before_action :set_resource, only: [:destroy]

  ASSOCIATIONS = [
    [user_favorite_videos: :video]
  ]

  # GET /api/v1/users/:user_id/favorite_videos
  def index
    user = User.eager_load(ASSOCIATIONS).find(resource_params[:user_id])
    render_404 unless user
    @user_favorite_videos = user.user_favorite_videos
  end

  # DELETE /api/v1/users/:user_id/favorite_videos/:video_id
  def destroy
    destroy_and_render_json(@user_favorite_video)
  end

private

  def set_resource
    @user_favorite_video = UserFavoriteVideo.where(resource_params).first
    render_404 unless @user_favorite_video
  end

  def resource_params
    params.permit(:user_id, :video_id)
  end
end
