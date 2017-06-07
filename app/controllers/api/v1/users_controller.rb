class Api::V1::UsersController < Api::V1::ApiController
  before_action :set_user, only: [:show, :update, :destroy]

  PERMITTED_ATTRIBUTES = [
    :email, :password, :confirmed, :visible, :role, :access_level,
    :first_name, :last_name, :bio, :image_url, :hero_url,
    :customer_uuid, :oauth, :oauth_provider,
    user_profile_attributes: [:birth_year, professions:[]]
  ]

  # GET /api/v1/users
  def index
    if !params[:role]
      @users = User.all
    else
      if User::ROLES.include?(params[:role])
        @users = User.send(params[:role].underscore.to_sym)
      else
        render json: {"role": ["not found"]}, status: :not_found
      end
    end
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

  # GET /api/v1/users/search
  # @example GET /api/v1/users/search?query[email]=search4me@gmail.com
  # @example GET /api/v1/users/search?query[role]=Artist&query[first_name]=Talenti
  def search
    begin
      @users = User.where(query_params)
    rescue ActionController::ParameterMissing
      render_query_400
    end
  end

private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(PERMITTED_ATTRIBUTES)
  end

  def query_params
    params.require(:query).permit(PERMITTED_ATTRIBUTES)
  end
end
