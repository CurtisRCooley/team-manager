Given /^I start on home page$/ do
  require "rubygems"
  gem "selenium-client", ">=1.2.16"
  require "selenium/client"
    @browser = Selenium::Client::Driver.new \
    :host => "localhost",
    :port => 4444,
    :browser => "*firefox",
    :url => "http://localhost:3000",
    :timeout_in_second => 60

    @browser.start_new_browser_session
end

Then /^title should be (.*)$/ do |title|
  @browser.open '/'
  assert_equal title, @browser.title
end

Then /^close browser$/ do
    @browser.close_current_browser_session
end
