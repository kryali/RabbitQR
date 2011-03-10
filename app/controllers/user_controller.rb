class UserController < ApplicationController

skip_before_filter :authenticate, :only => [:login, :login_form, :signup]

def login
#  @user = User.where({:username => params[:user][:username], :password => params[:user][:password]})
  @user = User.find(:first, :conditions => {:username => params[:user][:username], :password => params[:user][:password]})
  session[:user_id] = @user.id
  respond_to do |format|
    if @user
        session[:user_id] = @user.id
        format.html { render :action => 'show' }
        format.json { render :json => @user }
    else
        render :json => @user
    end
  end
end

def logout
  session[:user_id] = nil
  @user = nil
  redirect_to :root
end

def signup
end

def login_form
end

def show
  logger.debug "===\nOMFG FOR\n==="
  unless isLoggedIn
    redirect_to :root
  end
  @user = User.find(session[:user_id])
end

# Create the user
def create
  logger.debug "===\nCreate User\n==="
  params[:user].delete(:phone)
  @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        session['userid'] = @user.id
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        logger.debug "\n\nErrors: #{@user.errors}"
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
end

end