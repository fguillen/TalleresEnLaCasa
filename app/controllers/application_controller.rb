# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ExceptionNotification::Notifiable
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  helper_method :admin?
  
  private
    def admin?
      return !session[:admin].nil?
    end
    
    def require_admin
      unless admin?
        flash[:alert] = "Sólo los administradores pueden acceder aquí."
        redirect_to login_url
        return false
      end
    end
end
