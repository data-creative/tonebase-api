class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #skip_before_action :verify_authenticity_token # do we still need the line above or can we get rid of it?
end
