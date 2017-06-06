RSpec.shared_context "authenticate requests using valid token", :shared_context => :metadata do

  # Add headers to perform token authentication
  before :each do
    token = ENV.fetch("TONEBASE_CLIENT_TOKEN")
    auth = ActionController::HttpAuthentication::Token.encode_credentials(token) #> Token token="abc123"
    request.headers.merge!({'HTTP_AUTHORIZATION': auth})
  end
end
