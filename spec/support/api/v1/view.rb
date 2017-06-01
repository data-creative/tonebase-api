module Api::V1::View
  def parsed_response
    response = JSON.parse(rendered)
  end

  def keys_of(hash)
    hash.symbolize_keys.keys
  end
end

RSpec.configure do |config|
  config.include Api::V1::View
end
