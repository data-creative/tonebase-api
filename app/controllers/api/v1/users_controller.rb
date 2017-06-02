class Api::V1::UsersController < Api::V1::ApiController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /api/v1/users
  def index
    @user = User.all # User.user
  end

  # GET /api/v1/users/:id
  def show
  end

  # POST /api/v1/users
  def create
    user = User.new(user_params)
    save_and_render_json(user)
  end

  # PUT /api/v1/users/:id
  def update
    update_and_render_json(@user, user_params)
  end

  # DELETE /api/v1/users/:id
  def destroy
    destroy_and_render_json(@user)
  end

private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :confirmed, :visible, :role, :access_level, :first_name, :last_name, :bio, :image_url, :hero_url)
  end
end
