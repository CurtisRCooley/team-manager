# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  before_filter :check_authentication,
                :check_authorization,
                :except => [ :register, :login, :logout, :validate, :reminder, :playing, :not_playing ]

  def check_authentication
    unless session[:user_id]
      session[:intended_action] = action_name
      redirect_to :controller => 'admin', :action => 'login'
      return false
    end
  end

  def check_authorization
    user = User.find(session[:user_id])
    logger.debug "Authorizing user: #{user.email}"
    unless user.roles.detect {|role|
      logger.debug "Trying role: #{role}"
      role.rights.detect {|right|
        logger.debug "Trying right: #{right}"
        right.controller == self.class.controller_path
      }
    }
    flash[:notice] = "You are not authorized to view the page you requested"
    request.env["HTTP_REFERER"] ? (redirect_to :back) : (redirect_to home_url)
    return false
    end
  end

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  #
end
