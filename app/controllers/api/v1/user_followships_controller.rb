class Api::V1::UserFollowshipsController < Api::V1::ApiController
  before_action :set_resource, only: [:destroy]

  # POST /api/v1/user_followships
  def create
    user_followship = UserFollowship.new(resource_params)
    save_and_render_json(user_followship)
  end

  # DELETE /api/v1/user_followships/:id
  def destroy
    destroy_and_render_json(@user_followship)
  end

private

  def set_resource
    @user_followship = UserFollowship.find(params[:id])
  end

  def resource_params
    params.require(:user_followship).permit(:user_id, :followed_user_id)
  end
end
