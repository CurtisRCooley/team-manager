require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  def setup
    session[:user_id] = users(:one).id
    session[:schedule_id] = schedules(:user_one_schedule).id
  end

  test "should get index" do
    get :index
    
    assert_response :success
    assert_not_nil assigns(:games)
    assert_equal 2, assigns(:games).size
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game" do
    assert_difference('Game.count') do
      post :create, :game => { }
    end

    assert_equal session[:schedule_id], assigns(:game).schedule_id
    assert_redirected_to game_path(assigns(:game))
  end

  test "should show game" do
    get :show, :id => games(:game1).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => games(:game1).to_param
    assert_response :success
  end

  test "should update game" do
    put :update, :id => games(:game1).to_param, :game => { :game_time => Date.today}
    assert_redirected_to game_path(assigns(:game))
  end

  test "should email players on game change" do
    put :update, :id => games(:game1).to_param, :game => {:game_time => Date.today }
    assert_emails 1
  end

  test "should destroy game" do
    assert_difference('Game.count', -1) do
      delete :destroy, :id => games(:game1).to_param
    end

    assert_redirected_to games_path
  end

#  test "should show playing status for game" do
#    get :playing_status, {:id => games(:user_two_game).id}, {:user_id => users(:two), :schedule_id => schedules(:user_two_schedule).id }
#    assert_equal 0, assigns(:undecided).length
#    assert_equal 1, assigns(:not_playing).length
#    assert_equal 1, assigns(:playing).length
#  end
end
