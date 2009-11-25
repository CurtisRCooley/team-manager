# Load mail configuration if not in test environment
if RAILS_ENV != 'test'
#  email_settings = YAML::load(File.open("#{RAILS_ROOT}/config/email.yml"))
#  ActionMailer::Base.smtp_settings = email_settings[RAILS_ENV] unless email_settings[RAILS_ENV].nil?
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.raise_delivery_errors = true 
  ActionMailer::Base.smtp_settings = {
    :address => "smtp.comcast.net",
    :port => 25,
    :domain => "thecooleys.org"
  }
end
