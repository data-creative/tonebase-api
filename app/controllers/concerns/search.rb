module Search
  extend ActiveSupport::Concern

  # Use in conjunction with `search_params` like:
  # params.permit([:title])
  #
  # @param [Array<ApplicationRecord>] resources
  def filter(resources)
    resources.where(search_params.to_h)
  end

  # Use in conjunction with `fuzzy_search_params` like:
  # params.permit(fuzzy: [:title, :tags])
  #
  # @param [Array<ApplicationRecord>] resources
  def fuzzy_filter(resources)
    fuzzy_search_params.to_h["fuzzy"].each do |k,v|
      resources = resources.where("#{k} ILIKE ?", "%#{v}%")
    end

    return resources
  end
end
