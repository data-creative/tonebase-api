module Api::V1::Response
  def parsed_response
    JSON.parse(response.body) #.deep_symbolize_keys
  end

  # @param [Array] attributes A list of keys representing attributes which should be blank.
  # @return [Hash]
  def compile_blank_params(attributes)
    paramz = {}
    attributes.each do |attribute|
      paramz[attribute.to_sym] = ""
    end
    return paramz
  end
end

RSpec.configure do |config|
  config.include Api::V1::Response
end
