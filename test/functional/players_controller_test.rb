require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  def setup
    session[:user_id] = users(:one).id
    session[:schedule_id] = schedules(:user_two_schedule).id
    ActionMailer::Base.deliveries = []
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:players)
  end

  test "should get new" do
    get :edit
    assert_response :success
  end

  test "should create player" do
    assert_difference('Player.count') do
      post :edit, :player => { }
    end

    assert_equal schedules(:user_two_schedule).id, assigns(:player).schedule_id
    assert_redirected_to :home
  end

  test "should show player" do
    get :show, :id => players(:player_one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => players(:player_one).to_param
    assert_response :success
  end

  test "should update player" do
    put :edit, :id => players(:player_one).to_param, :player => { }
    assert_response :redirect
  end

  test "should destroy player" do
    assert_difference('Player.count', -1) do
      delete :destroy, :id => players(:player_one).to_param
    end

    assert_redirected_to :home
  end

  test "should remind players" do
    session.clear
    PlayersController.reminder
    assert_emails 3
    to_list = ActionMailer::Base.deliveries.collect {|delivery| delivery.to.to_s}
    assert to_list.include?("player@one.com"), "Expected to list to contain 'player@one.com'"
    assert to_list.include?(users(:two).email)
    assert_equal "Game Reminder", ActionMailer::Base.deliveries[0].subject
    assert_equal users(:two).email, ActionMailer::Base.deliveries[0].from[0]
  end

  test "should email players" do
    post :email, {:subject => "subject", :message => "the message"}, {:user_id => users(:two).id, :schedule_id => schedules(:user_two_schedule).id }
    assert_emails 1
    assert_equal 1, ActionMailer::Base.deliveries.length
    assert_equal %w[in@cti.ve player@one.com player@two.com reserve@me.com].sort, ActionMailer::Base.deliveries[0].to.sort
    assert_equal "Rec Team Captain: subject", ActionMailer::Base.deliveries[0].subject
    assert_equal users(:two).email, ActionMailer::Base.deliveries[0].from[0]
    assert_equal "Message sent", flash[:notice]
  end

  test "should mark player as playing" do
    session.clear
    player = players(:player_one)
    game = games(:game1)
    get :playing, :player_id => player.to_param, :game_id => game.to_param
    assert_equal PlayingStatus::PLAYING, player.playing_statuses[0].playing_status 
    assert_equal player.playing_statuses[0], game.playing_statuses[0]
  end

  test "should mark player as not playing" do
    session.clear
    player = players(:player_one)
    game = games(:game1)
    get :not_playing, :player_id => player.to_param, :game_id => game.to_param
    assert_equal PlayingStatus::NOT_PLAYING, player.playing_statuses[0].playing_status 
    assert_equal player.playing_statuses[0], game.playing_statuses[0]
  end

  test "should email reserve when player not playing" do
    player = players(:player_one)
    game = games(:game1)
    get :not_playing, :player_id => player.to_param, :game_id => game.to_param
    assert_emails 1
    to = ActionMailer::Base.deliveries[0].to
    get :not_playing, :player_id => player.to_param, :game_id => game.to_param
    assert_not_equal to, ActionMailer::Base.deliveries[1].to
  end
end
