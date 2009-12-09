require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  def setup
    session[:user_id] = users(:one).id
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

    assert_equal users(:one).id, assigns(:player).user_id
    assert_redirected_to :action => 'index'
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
    assert_response :success
  end

  test "should destroy player" do
    assert_difference('Player.count', -1) do
      delete :destroy, :id => players(:player_one).to_param
    end

    assert_redirected_to :action => 'index'
  end

  test "should email players" do
    get :reminder
    assert_equal 2, ActionMailer::Base.deliveries.length
    assert_equal %w[player@one.com], ActionMailer::Base.deliveries[0].to
    assert_equal "Game Reminder", ActionMailer::Base.deliveries[0].subject
    assert_equal users(:two).email, ActionMailer::Base.deliveries[0].from[0]
  end

  test "should mark player as playing" do
    player = players(:player_one)
    game = games(:game1)
    get :playing, :player_id => player.to_param, :game_id => game.to_param
    assert_equal PlayingStatus::PLAYING, player.playing_statuses[0].playing_status 
    assert_equal player.playing_statuses[0], game.playing_statuses[0]
  end

  test "should mark player as not playing" do
    player = players(:player_one)
    game = games(:game1)
    get :not_playing, :player_id => player.to_param, :game_id => game.to_param
    assert_equal PlayingStatus::NOT_PLAYING, player.playing_statuses[0].playing_status 
    assert_equal player.playing_statuses[0], game.playing_statuses[0]
  end
end
