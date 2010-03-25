class AAccountsController < ApplicationController
   
    @a_user = Administrator.find_by_a_id(session[:aid]) if defined? session[:aid]    
    
  def login
    @a_user = Administrator.new
    # @a_user.loginname = params[:login_name]

    if request.post?
      @a_user = Administrator.find_by_login_name(params[:a_user][:login_name]) 
    
        if @a_user.password == params[:a_user][:password]
          session[:administrator] = true
          session[:aid] = @a_user.a_id # Remember the user's id during this session 
          redirect_to :action => :my_account
        else
          flash[:error] = 'Invalid login.'
          redirect_to :action => :login
        end
  
    end
  end 

  def my_account
  end
  
  def logout
    reset_session
    flash[:message] = 'Logged out.' 
    redirect_to :action => 'login' 
  end
  
end
