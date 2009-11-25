require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  # replace this with your real tests
  test "email on user creation" do
    User.create(:email => 'foo@bar.com', :password => 'secret')
    deliveries = ActionMailer::Base.deliveries
    assert_equal 1, deliveries.length
    assert_equal 'foo@bar.com', deliveries[0].to[0]
  end
end
