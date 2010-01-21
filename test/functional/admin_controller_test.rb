require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  def setup
    session[:user_id] = users(:one).id
  end

  test "users report" do
    get :users_report, {}, {:user_id => users(:one).id}
    assert_response :success
    assert_equal 3, assigns(:users).length
  end

  test "schedule created on user validation" do
    user = users(:new)
    get :validate, :id => user.id, :registration_key => 'registration_key'
    assert_redirected_to :action => 'login', :controller => 'admin'
    schedules = assigns(:user).schedules
    assert_equal 1, schedules.size
    assert_equal 4, schedules[0].notification_days 
    assert_equal 0, schedules[0].minimum_players
    assert_equal "#{user.email} Schedule", schedules[0].name
  end
end
