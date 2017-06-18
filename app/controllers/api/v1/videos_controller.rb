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
    videos = videos.where(query_params) if query_params.to_h.any?
    videos = filter_on_array_inclusion(videos) if array_query_params.any?
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

  def query_params
    params.permit([:title])
  end

  def array_query_params
    params.permit([:tags]).to_h
  end

  def filter_on_array_inclusion(resources)
    array_query_params.each do |k,v|
      resources = resources.where("#{k} ILIKE ?", "%#{v}%")
    end
    return resources
  end
end
