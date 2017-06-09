class Api::V1::AnnouncementsController < Api::V1::ApiController
  before_action :set_announcement, only: [:show, :update, :destroy]

  # GET /api/v1/announcements
  def index
    @announcements = Announcement.all
  end

  # GET /api/v1/announcements/:id
  def show
  end

  # POST /api/v1/announcements
  def create
    announcement = Announcement.new(announcement_params)
    save_and_render_json(announcement)
  end

  # PUT /api/v1/announcements/:id
  def update
    update_and_render_json(@announcement, announcement_params)
  end

  # DELETE /api/v1/announcements/:id
  def destroy
    destroy_and_render_json(@announcement)
  end

private

  def set_announcement
    @announcement = Announcement.find(params[:id])
  end

  def announcement_params
    params.require(:announcement).permit(:title, :content, :url, :image_url, :broadcast)
  end
end
