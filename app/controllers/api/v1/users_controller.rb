class Api::V1::UsersController < Api::V1::ApiController
  before_action :set_user, only: [:show, :update, :destroy]

  PERMITTED_ATTRIBUTES = [
    :email, :password, :username,
    :confirmed, :visible, :role, :access_level,
    :customer_uuid, :oauth, :oauth_provider,
    user_profile_attributes: [:first_name, :last_name, :bio, :image_url, :hero_url, :birth_year, professions:[]],
    user_music_profile_attributes: [:guitar_owned, guitar_models_owned:[], fav_composers:[], fav_performers:[], fav_periods:[]]
  ]

  ASSOCIATIONS = [
    :user_profile, :user_music_profile,
    [follows: :user_profile],
    [followers: :user_profile],
    :favorite_videos,
    :recent_video_views,
    [user_notifications: :notification]
  ]

  # GET /api/v1/users
  def index
    if !params[:role]
      users = User.eager_load(ASSOCIATIONS).all
      render_paginated(users)
    else
      if User::ROLES.include?(params[:role])
        users = User.eager_load(ASSOCIATIONS).send(params[:role].underscore.to_sym)
        render_paginated(users)
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

  # @deprecated
  # GET /api/v1/users/search
  # @example GET /api/v1/users/search?query[email]=search4me@gmail.com
  # @example GET /api/v1/users/search?query[role]=Artist&query[first_name]=Talenti
  def search
    begin
      @users = User.eager_load(ASSOCIATIONS).where(query_params)
    rescue ActionController::ParameterMissing
      render_query_400
    end
  end

private

  def set_user
    @user = User.eager_load(ASSOCIATIONS).find(params[:id])
  end

  def user_params
    params.require(:user).permit(PERMITTED_ATTRIBUTES)
  end

  # @deprecated
  def query_params
    params.require(:query).permit(PERMITTED_ATTRIBUTES)
  end
end
