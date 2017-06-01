class Api::V1::ApiController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

private

  def render_404
    render json: {"id": ["not found"]}, status: :not_found
  end

  # @deprecated
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
end
