desc "Send reminder emails"
task :cron do |t|
  require 'net/http'
  Net::HTTP.get 'recteamcaptain.heroku.com', '/players/reminder'
end
