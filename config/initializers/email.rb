# Load mail configuration if not in test environment
if RAILS_ENV != 'test'
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.raise_delivery_errors = true 
  ActionMailer::Base.smtp_settings = {
    :address => "smtp.comcast.net",
    :user_name => "curtiscooley",
    :password => "Perturbed",
    :authentication => :login,
    :port => 25,
  }
end
