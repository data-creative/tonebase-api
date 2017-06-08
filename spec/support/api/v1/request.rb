
# Applies valid request headers like... "HTTP_AUTHORIZATION"=>"Token token=\"abc123\""
RSpec.shared_context "authenticate requests using valid token", :shared_context => :metadata do
  before :each do
    token = ENV.fetch("TONEBASE_CLIENT_TOKEN")
    auth = ActionController::HttpAuthentication::Token.encode_credentials(token) #> Token token="abc123"
    request.headers.merge!({'HTTP_AUTHORIZATION': auth})
  end
end

# Applies invalid request headers like... "HTTP_AUTHORIZATION"=>"Token token=\"OOPS\""
RSpec.shared_context "authenticate requests using invalid token", :shared_context => :metadata do
  before :each do
    token = "OOPS"
    auth = ActionController::HttpAuthentication::Token.encode_credentials(token) #> Token token="abc123"
    request.headers.merge!({'HTTP_AUTHORIZATION': auth})
  end
end
