class PlayersController < ApplicationController
  skip_before_filter :check_authorization
  # GET /players
  # GET /players.xml
  def index
    @players = User.find_by_id(session[:user_id]).players

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @players }
    end
  end

  # GET /players/1
  # GET /players/1.xml
  def show
    @player = Player.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @player }
    end
  end

  # GET /players/1/edit
  def edit
    @player = Player.find_by_id(params[:id]) || Player.new
    @player.user = User.find(session[:user_id])
    if request.post?
      @player.attributes = params[:player]
      redirect_to :action => 'index' and return if @player.save
    end
  end

  # DELETE /players/1
  # DELETE /players/1.xml
  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    respond_to do |format|
      format.html { redirect_to(:action => 'index') }
      format.xml  { head :ok }
    end
  end

  def reminder
    User.all.each { |user|
      upcoming_games(user).each { |game|
        UserMailer.deliver_reminder_email(Player.find_all_by_user_id(user.id), game, user)
      }
    }
      
  end

  private
    def upcoming_games(user)
      user.games.select { |game| game.game_time <= 4.days.from_now  && game.game_time > 3.days.from_now }
    end
end
