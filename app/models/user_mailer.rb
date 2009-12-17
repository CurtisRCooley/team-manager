class UserMailer < ActionMailer::Base
  def welcome_email(user)
    recipients user.email 
    from "Curtis Cooley <curtis@thecooleys.org>"  
    subject "Welcome to Team Captain"  
    sent_on Time.now 
    body :user => user, :url => "http://team-manager.heroku.com/admin/validate/#{user.registration_key}/#{user.id}"
  end 

  def reminder_email(player, game, user)
    recipients player.email
    from user.email
    subject "Game Reminder"
    sent_on Time.now 
    body :game => game, :player => player
  end

  def bulk_emails(emails, from, the_subject, message)
    recipients emails
    from from
    subject the_subject
    body message
  end
end
