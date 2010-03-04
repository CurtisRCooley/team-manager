include Email

class PlayersController < ApplicationController
  skip_before_filter [ :check_authorization, :playing, :not_playing, :reminder ]
  # GET /players
  # GET /players.xml
  def index
    @players = Schedule.find_by_id(session[:schedule_id]).players

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
    @player.schedule = Schedule.find(session[:schedule_id])
    if request.post? || request.put?
      @player.attributes = params[:player]
      redirect_to :home and return if @player.save!
    end
  end

  # DELETE /players/1
  # DELETE /players/1.xml
  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    respond_to do |format|
      format.html { redirect_to(:home) }
      format.xml  { head :ok }
    end
  end

  def playing
    mark_playing_status(PlayingStatus::PLAYING)
  end

  def not_playing
    mark_playing_status(PlayingStatus::NOT_PLAYING)
    email_reserve
  end

  def reminder
    User.all.each { |user|
      user.schedules.each { |schedule|
        upcoming_games(schedule).each { |game|
          UserMailer.deliver_reminder_email(user, game, user, schedule)
          Player.find(:all, :conditions => ["schedule_id = ? and (reserve = ? or reserve is null)", schedule.id, false]).each { |player|
            UserMailer.deliver_reminder_email(player, game, user, schedule)
          }
        }
      }
    }
  end

  def email
    if request.post?
      bulk_email Player.find_all_by_schedule_id(session[:schedule_id]).collect { |player| player.email }
      redirect_to home_url
    end
  end

  private
    def upcoming_games(schedule)
      Game.find(:all,
        :conditions => ["schedule_id = ? AND game_time <= ? AND game_time > ?",
	  schedule.id, schedule.notification_days.days.from_now,
          (schedule.notification_days - 1).days.from_now])
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

    def email_reserve
      game = Game.find_by_id(params[:game_id])
      schedule = game.schedule
      user = schedule.user
      schedule.reserves.each do |reserve|
        if ! game.players.include?(reserve) 
          @player = reserve
	  game.players << reserve
          break
	end	  
      end
      UserMailer.deliver_reminder_email(@player, game, user, schedule)
    end
end
