class GamesController < ApplicationController
  skip_before_filter :check_authorization
  # GET /games
  # GET /games.xml
  def index
    @games = Schedule.find_by_id(session[:schedule_id]).games

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @games }
    end
  end

  # GET /games/1
  # GET /games/1.xml
  def show
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @game }
    end
  end

  # GET /games/new
  # GET /games/new.xml
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /games
  # POST /games.xml
  def create
    @game = Game.new(params[:game])
    @game.schedule_id = session[:schedule_id]

    respond_to do |format|
      if @game.save
        flash[:notice] = 'Game was successfully created.'
        format.html { redirect_to(:home) }
        format.xml  { render :xml => @game, :status => :created, :location => @game }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.xml
  def update
    @game = Game.find(params[:id])
    update_players(@game, params[:game])
    respond_to do |format|
      if @game.update_attributes(params[:game])
        flash[:notice] = 'Game was successfully updated.'
        format.html { redirect_to(:home) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.xml
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to(:home) }
      format.xml  { head :ok }
    end
  end

  def playing_status
    @game = Game.find_by_id(params[:id])
    @playing = []
    @not_playing = []
    @undecided = []
    Player.find_all_by_schedule_id(session[:schedule_id]).each do |player|
      playing_status = PlayingStatus.find_by_game_id_and_player_id(@game.id, player.id)
      if playing_status
        if playing_status.playing_status == PlayingStatus::PLAYING
          @playing << player
        else
          @not_playing << player
        end
      else
        @undecided << player
      end
    end
  end

  private
  def update_players(old_game, new_game_params)
    players_email = Schedule.find(session[:schedule_id]).players.collect do |player| 
      player.email
    end
    UserMailer.deliver_game_change(players_email, old_game, Game.new(new_game_params), User.find(session[:user_id]))
  end
end
