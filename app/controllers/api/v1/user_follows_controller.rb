class Api::V1::UserFollowsController < Api::V1::ApiController
  before_action :set_resource, only: [:destroy]

  # POST /api/v1/user_follows
  def create
    user_follow = UserFollow.new(resource_params)
    save_and_render_json(user_follow)
  end

  # DELETE /api/v1/user_follows/:id
  def destroy
    destroy_and_render_json(@user_follow)
  end

private

  def set_resource
    @user_follow = UserFollow.find(params[:id])
  end

  def resource_params
    params.require(:user_follow).permit(:user_id, :follower_id)
  end
end
