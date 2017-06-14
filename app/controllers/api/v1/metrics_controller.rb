class Api::V1::MetricsController < Api::V1::ApiController

  # GET /api/v1/metrics/users-total
  def total_users
    render_json({total: User.count})
  end
end
