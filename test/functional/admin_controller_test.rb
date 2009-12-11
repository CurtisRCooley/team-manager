require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  def setup
    session[:user_id] = users(:one).id
  end

  test "users report" do
    get :users_report, {}, {:user_id => users(:one).id}
    assert_response :success
    assert_equal 2, assigns(:users).length
  end
end
