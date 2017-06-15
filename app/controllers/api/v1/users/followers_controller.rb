class Api::V1::Users::FollowersController < Api::V1::ApiController
  # GET /api/v1/users/:user_id/followers
  def index
    @user_followships = UserFollowship.where(followed_user_id: resource_params[:user_id])
  end

private

  def resource_params
    params.permit(:user_id)
  end
end
