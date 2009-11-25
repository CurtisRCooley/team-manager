require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user_id = users(:one).id
    session[:user_id] = @user_id
  end
  
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :edit
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :edit, :user => {:email => 'the_email@here.ca', :password => 'secret', :password_confirmation => 'secret' }
    end

    assert_redirected_to :action => 'index'
  end

  test "should show user" do
    get :show, :id => users(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => users(:one).to_param
    assert_response :success
  end

  test "should update user" do
    put :edit, {:id => users(:one).id, :user => { }}
    assert_response :success
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, :id => users(:one).to_param
    end

    assert_redirected_to users_path
  end
end
