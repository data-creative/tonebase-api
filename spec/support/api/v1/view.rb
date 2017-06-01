module Api::V1::View
  def parsed_response
    JSON.parse(rendered).deep_symbolize_keys
  end
end

RSpec.configure do |config|
  config.include Api::V1::View
end
