class UserMailer < ActionMailer::Base
  def welcome_email(user)
    recipients user.email 
    from "Curtis Cooley <curtis@thecooleys.org>"  
    subject "Welcome to Team Captain"  
    sent_on Time.now 
    body :user => user, :url => "http://localhost:3000/admin/validate/#{user.registration_key}/#{user.id}"
  end 

  def reminder_email(players, game, user)
    recipients players.collect { |player| player.email }
    from user.email
    subject "Game Reminder"
    sent_on Time.now 
    body :game => game
  end
end
