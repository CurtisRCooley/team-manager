require 'digest/sha1'
include Email

class AdminController < ApplicationController
  before_filter :check_authentication, :except => [:login, :validate, :register]

  def register
    @user = User.new(:registration_key => Digest::SHA1.hexdigest(rand.to_s))
    if request.post?
      logger.info params[:user_email]
      logger.info params[:user_password]
      logger.info params[:user_password_confirmation]
      @user.attributes = params[:user]
      flash[:notice] = "An email has been sent to #{@user.email} with a link to complete your registration"
      redirect_to :home and return if @user.save
    end
  end

  def login
    if request.post?
      user = User.authenticate(params[:email], params[:password])
      if user
        session[:user_id] = user.id
        redirect_to :home
      else
        flash.now[:notice] = 'Invalid user/password'
      end
    end
  end

  def logout
    session[:user_id] = nil
    session[:schedule_id] = nil
    redirect_to '/'
  end

  def index
    @users = User.all
  end

  def validate
    @user = User.find(params[:id])
    if (@user && @user.registration_key == params[:registration_key])
      @user.registration_key = nil
      @user.schedules << Schedule.new(:name => "#{@user.email} Schedule", 
                                      :notification_days => 4, 
                                      :minimum_players => 0)
      @user.save
      flash[:notice] = "Thank you. Your Registration is complete. You may login"
      redirect_to :action => 'login'
    else
      flash[:notice] = "Invalid registration key"
      redirect_to :controller => 'users', :action => 'new'
    end
  end

  def users_report
    @users = User.all
  end

  def email
    if request.post?
      bulk_email User.all.collect { |user| user.email }
      redirect_to :controller => 'admin'
    end
  end

end
