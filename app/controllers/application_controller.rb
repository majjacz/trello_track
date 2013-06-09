class ApplicationController < ActionController::Base

  before_filter :require_user

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def current_user
      @current_user ||= User.where(:auth_token => session[:auth_token]).first if session[:auth_token]
    end
    helper_method :current_user

    def require_user
      redirect_to login_path if current_user.nil?
    end

end
