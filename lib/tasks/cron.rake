desc "Send reminder emails"
task :cron do |t|
  require 'net/http'
  Net::HTTP.get 'localhost', '/players/reminder', '3000'
end
