class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  # Just use default (:null_session) for this super simple app
  protect_from_forgery

  before_action :set_current_user

  private
 
    def set_current_user
      @current_user = User.find(1)
    end
end
