class Api::V1::UsersController < Api::V1::ApiController
  include Search
  include UserProfileSearch

  before_action :set_user, only: [:show, :update, :destroy]

  PERMITTED_ATTRIBUTES = [
    :email,
    :password,
    :username,
    :confirmed,
    :visible,
    :role,
    :access_level,
    :customer_uuid,
    :oauth,
    :oauth_provider,
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
    users = User.eager_load(ASSOCIATIONS).all
    users = filter(users) if search_params.to_h.any?
    users = profile_filter(users) if profile_search_params.to_h.any?
    #users = fuzzy_filter(users) if fuzzy_search_params.to_h.any?
    users = profile_fuzzy_filter(users) if profile_fuzzy_search_params.to_h.any?
    render_paginated(users)
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
    @user = User.eager_load(ASSOCIATIONS).find(params[:id])
  end

  def user_params
    params.require(:user).permit(PERMITTED_ATTRIBUTES)
  end

  def search_params
    params.permit([:email, :username, :confirmed, :visible, :role, :access_level, :customer_uuid])
  end

  #def fuzzy_search_params
  #  params.permit(fuzzy: [:email, :username])
  #end

  def profile_search_params
    params.permit([:first_name, :last_name])
  end

  def profile_fuzzy_search_params
    params.permit(fuzzy: [:name, :first_name, :last_name])
  end
end
