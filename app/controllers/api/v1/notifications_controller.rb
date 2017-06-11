class Api::V1::NotificationsController < Api::V1::ApiController
  before_action :set_notification, only: [:show, :destroy]

  # GET /api/v1/notifications
  def index
    @notifications = Notification.all
  end

  # GET /api/v1/notifications/:id
  def show
  end

  # DELETE /api/v1/notifications/:id
  def destroy
    destroy_and_render_json(@notification)
  end

private

  def set_notification
    @notification = Notification.find(params[:id])
  end
end
