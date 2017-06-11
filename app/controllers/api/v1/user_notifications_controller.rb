class Api::V1::UserNotificationsController < Api::V1::ApiController
  before_action :set_user_notification, only: [:update]

  # PUT /api/v1/user_notifications/:id
  def update
    update_and_render_json(@user_notification, user_notification_params)
  end

private

  def set_user_notification
    @user_notification = UserNotification.find(params[:id])
  end

  def user_notification_params
    params.require(:user_notification).permit(:user_id, :notification_id, :marked_read)
  end
end
