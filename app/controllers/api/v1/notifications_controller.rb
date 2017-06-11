class Api::V1::NotificationsController < Api::V1::ApiController
  before_action :set_notification, only: [:show, :destroy]

  ASSOCIATIONS = [
    [users: :user_profile],
  ]

  # GET /api/v1/notifications
  def index
    @notifications = Notification.eager_load(ASSOCIATIONS).all
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
    @notification = Notification.eager_load(ASSOCIATIONS).find(params[:id])
  end
end
