module UserProfileSearch
  extend ActiveSupport::Concern

  # Use in conjunction with `profile_search_params` like:
  # params.permit([:first_name, :last_name])
  #
  # @param [Array<ApplicationRecord>] resources
  #
  def profile_filter(resources)
    profile_search_params.to_h.each do |k,v|
      resources = resources.where("user_profiles.#{k} = ?", v)
    end

    return resources
  end

  # Use in conjunction with `profile_fuzzy_search_params` like:
  # params.permit(fuzzy: [:name, :first_name, :last_name])
  #
  # @param [Array<ApplicationRecord>] resources
  #
  def profile_fuzzy_filter(resources)
    profile_fuzzy_search_params.to_h["fuzzy"].each do |k,v|
      if k == "name"
        resources = resources.where("user_profiles.first_name ILIKE :name OR user_profiles.last_name ILIKE :name", name: "%#{v}%")
      else
        resources = resources.where("user_profiles.#{k} ILIKE ?", "%#{v}%")
      end
    end

    return resources
  end
end
