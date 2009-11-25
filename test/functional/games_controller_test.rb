require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  def setup
    session[:user_id] = users(:one).id
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

    assert_equal session[:user_id], assigns(:game).user_id
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
    put :update, :id => games(:game1).to_param, :game => { }
    assert_redirected_to game_path(assigns(:game))
  end

  test "should destroy game" do
    assert_difference('Game.count', -1) do
      delete :destroy, :id => games(:game1).to_param
    end

    assert_redirected_to games_path
  end
end
