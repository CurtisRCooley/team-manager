class UsersController < ApplicationController
  
  def edit
    @user = User.find_by_id(params[:id]) || User.new()
    if request.post?
      @user.attributes = params[:user]
      redirect_to :action => 'index' and return if @user.save
    end
  end

  # GET /users
  # GET /users.xml
  def index
    @users = User.find(:all, :order => :email)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
