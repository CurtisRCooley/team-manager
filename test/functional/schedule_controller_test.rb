require 'test_helper'

class ScheduleControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "can not view other users schedules" do
    get :show, {:id => schedules(:user_one_schedule).to_param},
      {:user_id => users(:two).id}
    assert_redirected_to :home
    assert_equal "You are not authorized to view that schedule", flash[:notice]
  end
end
