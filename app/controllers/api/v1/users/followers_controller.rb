class Api::V1::Users::FollowersController < Api::V1::ApiController
  # GET /api/v1/users/:user_id/followers
  def index
    user = User.find(resource_params[:user_id])
    render_404 unless user
    @user_followships = user.inverse_user_followships
  end

private

  def resource_params
    params.permit(:user_id)
  end
end
