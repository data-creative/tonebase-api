class Api::V1::VideosController < Api::V1::ApiController
  before_action :set_video, only: [:show, :update, :destroy]

  PERMITTED_ATTRIBUTES = [
    :user_id,
    :instrument_id,
    :title,
    :description,
    tags: [],
    video_parts_attributes: [:source_url, :number, :duration],
    video_scores_attributes: [:image_url, :starts_at, :ends_at],
  ]

  ASSOCIATIONS = [
    :video_parts, :video_scores,
    [user: :user_profile],
    :instrument,
    [favorited_by_users: :user_profile],
    [viewed_by_users: :user_profile]
  ]

  # GET /api/v1/videos
  def index
    videos = Video.eager_load(ASSOCIATIONS).all
    videos = filter(videos) if search_params.to_h.any?
    #videos = fuzzy_filter(videos) if fuzzy_search_params.to_h.any?
    render_paginated(videos)
  end

  # GET /api/v1/videos/:id
  def show
  end

  # POST /api/v1/videos
  def create
    video = Video.new(video_params)
    save_and_render_json(video)
  end

  # PUT /api/v1/videos/:id
  def update
    update_and_render_json(@video, video_params)
  end

  # DELETE /api/v1/videos/:id
  def destroy
    destroy_and_render_json(@video)
  end

private

  def set_video
    @video = Video.eager_load(ASSOCIATIONS).find(params[:id])
  end

  def video_params
    params.require(:video).permit(PERMITTED_ATTRIBUTES)
  end

  def search_params
    params.permit([:title])
  end

  def filter(resources)
    resources.where(search_params.to_h)
  end

  def fuzzy_search_params
    params.require(:fuzzy).permit([:title, :tags])
  end

  def fuzzy_filter(resources)
    fuzzy_search_params.to_h.each do |k,v|
      resources = resources.where("#{k} ILIKE ?", "%#{v}%")
    end
    return resources
  end
end
