desc "Send reminder emails"
task :cron do |t|
  require 'net/http'
  Net::HTTP.get 'team-manager.heroku.com', '/players/reminder'
end
