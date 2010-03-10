Given /^schedule (.+) belongs to user (.+)$/ do |schedule_name, user_name|
  user = User.find_by_email!(user_name)
  schedule = Schedule.find_by_name(schedule_name) || Schedule.new(:name => schedule_name)
  schedule.user == user
  user.schedules << schedule
  session[:schedule_id] = schedule.id
  visit "/"
end

Given /^player (.+) belongs to user (.+)$/ do |player, user|
  player = Player.find_by_email(player) || Player.new(:email => player)
  schedule = User.find_by_email!(user).schedules[0]
  schedule.players << player
  player.schedule = schedule
  session[:schedule_id] = schedule.id
end

Given /^game (.+) belongs to schedule (.+)$/ do |game, schedule|
  game = Game.find_by_game_time(game) || Game.new(:game_time => Date.today)
  schedule = Schedule.find_by_name(schedule)
  schedule.games << game
  game.schedule = schedule
  session[:schedule_id] = schedule.id
end

When /^user creates game (.+)$/ do |game|
  When "I am on \"the home page\""
  When "I follow \"Add Game\""
  When "I fill in \"location\" with \"place\""
  When "I fill in \"note\" with \"Note\""
  When "I press \"Create\""
  Then "I should be on \"the home page\""
end


