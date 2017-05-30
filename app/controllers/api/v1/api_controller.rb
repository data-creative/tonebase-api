class Api::V1::ApiController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

private

  def render_404
    render json: {"id": ["not found"]}, status: :not_found
  end
end
