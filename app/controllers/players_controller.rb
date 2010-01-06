class PlayersController < ApplicationController
  skip_before_filter [ :check_authorization, :playing, :not_playing, :reminder ]
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

  def playing
    mark_playing_status(PlayingStatus::PLAYING)
  end

  def not_playing
    mark_playing_status(PlayingStatus::NOT_PLAYING)
  end

  def reminder
    User.all.each { |user|
      user.schedules.each { |schedule|
        upcoming_games(schedule).each { |game|
          schedule.players.each { |player|
            UserMailer.deliver_reminder_email(player, game, user)
          }
        }
      }
    }
  end

  def email
    if request.post?
      user = User.find_by_id(session[:user_id])
      emails = user.players.collect { |player| player.email }
      UserMailer.deliver_bulk_emails(emails, user.email, params[:subject], params[:message])
      flash[:notice] = "Message sent"
      redirect_to home_url
    end
  end

  private
    def upcoming_games(schedule)
      Game.find(:all,
        :conditions => ["schedule_id = ? AND game_time <= ? AND game_time > ?",
	  schedule.id, 4.days.from_now, 3.days.from_now])
    end

    def mark_playing_status(status)
      logger.info("Playing status: #{status}")
      playing_status = PlayingStatus.find(:first,
                                          :conditions => ["player_id = ? and game_id = ?", params[:player_id], params[:game_id]]) || PlayingStatus.create
      playing_status.playing_status = status
      playing_status.save
      @player = Player.find_by_id(params[:player_id])
      @game = Game.find_by_id(params[:game_id])
      @game.playing_statuses << playing_status
      @player.playing_statuses << playing_status
      @game.save
      @player.save
    end
end
