class Api::V1::Users::FollowersController < Api::V1::ApiController
  ASSOCIATIONS = [
    [inverse_user_followships: [user: :user_profile]]
  ]

  # GET /api/v1/users/:user_id/followers
  def index
    user = User.eager_load(ASSOCIATIONS).find(resource_params[:user_id])
    render_404 unless user
    render_paginated(user.inverse_user_followships)
  end

private

  def resource_params
    params.permit(:user_id)
  end
end
