module Email
  def bulk_email(emails)
    if request.post?
      UserMailer.deliver_bulk_emails(emails, User.find_by_id(session[:user_id]).email, params[:subject], params[:message])
      flash[:notice] = "Message sent"
    end
  end
end
