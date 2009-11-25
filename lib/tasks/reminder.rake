desc "Send reminder emails"
task :reminder_emails do |t|
  require 'net/http'
  Net::HTTP.get 'localhost', '/players/reminder', '3000'
end
