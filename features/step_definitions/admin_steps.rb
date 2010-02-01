Given /^I am not logged in$/ do 
    visit front_url
end

Given /^a user is logged in as (.*)$/ do |name|
  Given "user #{name} exists"
  Given "log in user #{name}"
end

Given /^an admin is logged in as (.*)$/ do |name|
  @current_user = Admin.create!(
    :name => name,
    :password => 'generic',
    :password_confirmation => 'generic'
  )
  @current_user.save
  Given "log in user #{name}"
end

Given /^user (.+) exists$/ do |name|
  @current_user = User.create!(
    :email => name,
    :password => 'generic',
    :password_confirmation => 'generic'
  )
end

Given /^log in user (.+)$/ do |name|
  visit "/admin/login" 
  fill_in("email", :with => name) 
  fill_in("password", :with => 'generic') 
  click_button("Login")
end

Given /^player (.+) exists$/ do |player|
  schedule = Schedule.create(:name => "the_schedule")
  session[:schedule_id] = schedule.id
  User.find_by_email("markEmark").schedules << schedule
  visit new_player_path
  fill_in('email', :with => player) 
  click_button('Create')
end

