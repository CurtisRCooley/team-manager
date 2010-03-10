desc "Send reminder emails"
task :cron  => :environment do
  PlayersController.reminder
end
