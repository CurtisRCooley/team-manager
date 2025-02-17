Given /^a new user (.+)$/ do |user|
  @user = user
end

When /^I register$/ do
  "When I go to \"the home page\""
  "When I follow Register"
  "Then I should see \"New User Registration\""
  "When I fill in \"email\" with \"#{@user}\""
  "When I fill in \"password\" with \"secret\""
  "When I fill in \"password_confirmation\" with \"secret\""
  "when I press \"Register\""
  "Then I should see \"email sent\""
  "Then I should be at \"the home page\""
  "Then user #{@user} should exist"
end  

Then /^user (.+) should exist$/ do |user|
  assert_not_nil User.find_by_email(user)
end

Then /^registration key should not be nil$/ do
  assert_not_nil User.find_by_email(@user).registration_key
end
