class Api::V1::ApiController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  skip_before_action :verify_authenticity_token # creates security vulnerabilities which are addressed by #authenticate_client_token
  before_action :authenticate_client_token, unless: -> {Rails.env.development?}

  CLIENT_TOKEN = ENV.fetch("TONEBASE_CLIENT_TOKEN")

  # GET /api/v1/hello ... use this endpoint to test client authentication.
  def hello
    render_json({message: "Congratulations, you have authenticated successfully."})
  end

private

  def pagination_params
    params.permit(:page, :per_page).to_h # call .to_h to avoid deprecation warning. see https://github.com/stripe/stripe-ruby/issues/377#issuecomment-287339934
  end

  # Use this in an index action to paginate the desired resources.
  # Use a corresponding view which references the @resources variable.
  # @param [Array<ApplicationRecord>] resources A list of resources to be paginated and passed to the view.
  # @example render_paginated(Video.all)
  def render_paginated(resources)
    if pagination_params[:page] && pagination_params[:per_page]
      @resources = resources.order(created_at: :asc).paginate(pagination_params)
    elsif params[:page] || params[:per_page]
      render_pagination_400
    else
      @resources = resources
    end
  end

  def render_404
    render json: {"id": ["not found"]}, status: :not_found
  end

  def render_pagination_400
    render json: {"pagination": ["when supplying pagination parameters, please use both 'page' and 'per_page'"]}, status: :bad_request
  end

  def render_query_400
    render json: {"query": ["should be a named URL parameter included in the request"]}, status: :bad_request
  end

  # @note Instead, use jbuilder whenever possible.
  # @param [ApplicationRecord, Hash, Array] result A response body.
  def render_json(result)
    respond_to do |format|
      format.json { render json: result }
    end
  end

  # @param [ApplicationRecord] resource One or more model instances.
  def save_and_render_json(resource)
    respond_to do |format|
      if resource.save
        format.json { render json: resource, status: :created}
      else
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # @param [ApplicationRecord] resource One or more model instances.
  # @param [Hash] resource_params Attribute names and values to be updated on the resource.
  def update_and_render_json(resource, resource_params)
    respond_to do |format|
      if resource.update(resource_params)
        format.json { render json: resource, status: :ok}
      else
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # @param [ApplicationRecord] resource One or more model instances.
  def destroy_and_render_json(resource)
    resource.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  # Forces client to pass an access token in the request headers, or else returns a 401 (Unauthorized) response: "HTTP Token: Access denied."
  # source: http://api.rubyonrails.org/classes/ActionController/HttpAuthentication/Token.html
  # usage: curl SOME_URL -H 'Authorization: Token token="abc123"'
  def authenticate_client_token
    authenticate_or_request_with_http_token do |token, _|
      ActiveSupport::SecurityUtils.secure_compare(
        ::Digest::SHA256.hexdigest(token),
        ::Digest::SHA256.hexdigest(CLIENT_TOKEN)
      ) # Compare the tokens in a time-constant manner, to mitigate timing attacks.
    end
  end
end
