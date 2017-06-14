class Api::V1::MetricsController < Api::V1::ApiController

  # GET /api/v1/metrics/users_total
  def users_total
    render_json({total: User.count})
  end

  # GET /api/v1/metrics/users_over_time
  def users_over_time
    @users = User.all.select("id, created_at, role, access_level")
  end
end
