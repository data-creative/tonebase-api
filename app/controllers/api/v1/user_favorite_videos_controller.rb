class Api::V1::UserFavoriteVideosController < Api::V1::ApiController
  before_action :set_resource, only: [:destroy]

  # POST /api/v1/user_favorite_videos
  def create
    user_favorite_video = UserFavoriteVideo.new(resource_params)
    save_and_render_json(user_favorite_video)
  end

  # DELETE /api/v1/user_favorite_videos/:id
  def destroy
    destroy_and_render_json(@user_favorite_video)
  end

private

  def set_resource
    @user_favorite_video = UserFavoriteVideo.find(params[:id])
  end

  def resource_params
    params.require(:user_favorite_video).permit(:user_id, :video_id)
  end
end
