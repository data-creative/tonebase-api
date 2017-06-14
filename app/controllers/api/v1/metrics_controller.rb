class Api::V1::MetricsController < Api::V1::ApiController

  # GET /api/v1/metrics/users_total
  def users_total
    result = User.group(:role, :access_level).count #> {["User", "Limited"]=>51, ["User", "Full"]=>50, ["Artist", "Full"]=>36, ["Admin", "Full"]=>1}
    result = result.to_a.map{|k, v| {role: k[0], access_level: k[1], total: v} }
    render_json(result)
  end

  # GET /api/v1/metrics/users_over_time
  def users_over_time
    @users = User.all.select("id, created_at, role, access_level")
  end
end
