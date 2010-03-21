ActionMailer::Base.delivery_method = :test
ActionMailer::Base.perform_deliveries = true

Before do
  # Scenario setup
  ActionMailer::Base.deliveries.clear
end
