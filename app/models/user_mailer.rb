class UserMailer < ActionMailer::Base
  def welcome_email(user)
    recipients user.email 
    from "curtis@thecooleys.org"  
    subject "Welcome to Team Captain"  
    sent_on Time.now 
    body :user => user, :url => "http://www.recteamcaptain.com/admin/validate/#{user.registration_key}/#{user.id}"
  end 

  def new_user_email(user)
    recipients "curtis@thecooleys.org"
    from "curtis@thecooleys.org"
    subject "New Rec Team Captain User"
    body "New user for Rec Team Captain #{user.email}"
  end

  def reminder_email(player, game, user, schedule)
    recipients player.email
    from user.email
    subject "Game Reminder"
    sent_on Time.now 
    body :game => game, :player => player, :schedule => schedule
  end

  def bulk_emails(emails, from, the_subject, message)
    recipients emails
    from from
    subject "Rec Team Captain: #{the_subject}"
    sent_on Time.now 
    body "#{message}\n\nhttp://www.recteamcaptain.com"
  end

  def game_change(players, old_game, new_game, user)
    recipients players
    from user.email
    subject "Game Change Update"
    sent_on Time.now 
    body :old_game => old_game, :new_game => new_game
  end
end
