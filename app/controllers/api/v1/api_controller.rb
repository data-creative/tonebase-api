class Api::V1::ApiController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  skip_before_action :verify_authenticity_token # creates security vulnerabilities which are addressed by #authenticate_client_token
  before_action :authenticate_client_token

  CLIENT_TOKEN = ENV.fetch("TONEBASE_CLIENT_TOKEN")

  # GET /api/v1/hello ... use this endpoint to test client authentication.
  def hello
    render_json({message: "Congratulations, you have authenticated successfully."})
  end

private

  def render_404
    render json: {"id": ["not found"]}, status: :not_found
  end

  # @deprecated Because using jbuilder instead.
  # @param [ApplicationRecord] resource One or more model instances.
  def render_json(resource)
    respond_to do |format|
      format.json { render json: resource }
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
