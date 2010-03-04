class WelcomeController < ApplicationController
  skip_before_filter :check_authorization, :check_authentication

  def index
    schedule = Schedule.find_by_id(session[:schedule_id]) 
    if schedule
      @games = schedule.games
      @players = schedule.players
    end
  end

  def schedule
    session[:schedule_id] = params[:id]
    redirect_to :home
  end
end
