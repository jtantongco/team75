class SAccountsController < ApplicationController
    
  @s_user = Supervisor.find_by_s_id(session[:sid]) if defined? session[:sid]    
    
  def login
    @s_user = Supervisor.new
    # @s_user.login_name = params[:login_name]

    if request.post?
      @s_user = Supervisor.find_by_login_name(params[:s_user][:login_name]) 
    
        if @s_user.password == params[:s_user][:password]
          session[:supervisor] = true
          session[:sid] = @s_user.s_id # Remember the user's id during this session 
          redirect_to :action => :my_account
        else
          flash[:error] = 'Invalid login.'
          redirect_to :action => :login
        end
  
    end
  end 

  def my_account
  end
  
  
  
end