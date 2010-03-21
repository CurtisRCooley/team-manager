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
    assert_equal "#{user.email}'s Team", schedules[0].name
  end

  test "registration email has correct url" do
    post :register, :user => {:email => 'm@n.com', :password => 'secret', :password_confirmation => 'secret'}
    user = User.find_by_email('m@n.com')
    assert_emails 2
    assert ActionMailer::Base.deliveries[0].body.include?("http://www.recteamcaptain.com/admin/validate/#{user.registration_key}/#{user.id}")
  end
end
