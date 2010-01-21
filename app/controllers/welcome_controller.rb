class WelcomeController < ApplicationController
  skip_before_filter :check_authorization, :check_authentication

  def index
  end

  def schedule
    session[:schedule_id] = params[:id]
    redirect_to :home
  end
end
