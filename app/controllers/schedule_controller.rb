class ScheduleController < ApplicationController
  skip_before_filter [ :check_authorization ]

  def index
    @schedules = Schedule.find_all_by_user_id(session[:user_id])
  end

  def show
    @schedule = Schedule.find_by_id(params[:id])
    if (session[:user_id] != @schedule.user_id)
      flash[:notice] = "You are not authorized to view that schedule"
      redirect_to :home
    end
    session[:schedule_id] = @schedule.id
  end

  def edit
    @schedule = Schedule.find_by_id(params[:id]) || Schedule.new (:notification_days => 4)
    if request.post? || request.put?
      @schedule.attributes = params[:schedule]
      redirect_to :action => 'show', :id => @schedule and return if @schedule.save
    end
  end
end
