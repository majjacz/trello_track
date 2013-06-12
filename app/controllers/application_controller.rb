class ApplicationController < ActionController::Base

  before_filter :require_user, :set_time_zone

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def last_reporting_url(url=nil)
    if url.nil?
      session[:last_reporting_view] || root_url
    else
      session[:last_reporting_view] = url
    end
  end

  private

    def current_user
      @current_user ||= User.where(:auth_token => session[:auth_token]).first if session[:auth_token]
    end
    helper_method :current_user

    def require_user
      redirect_to login_path if current_user.nil?
    end

    def set_time_zone
      time_zone = cookies["browser.timezone"]
      Time.zone =  time_zone if time_zone.present?
    end

end
