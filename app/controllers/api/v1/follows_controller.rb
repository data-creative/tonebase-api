class Api::V1::FollowsController < Api::V1::ApiController
  before_action :set_resource, only: [:destroy]

  # GET /api/v1/users/:user_id/follows
  def index
    @user_followships = UserFollowship.where(user_id: resource_params[:user_id])
  end

  # DELETE /api/v1/users/:user_id/follows/:followed_user_id
  def destroy
    destroy_and_render_json(@user_followship)
  end

private

  def set_resource
    @user_followship = UserFollowship.where(resource_params)
  end

  def resource_params
    params.permit(:user_id, :followed_user_id)
  end
end
