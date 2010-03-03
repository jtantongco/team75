class AccountsController < ApplicationController
    before_filter :login_required, :only => :my_account
    
    def login
      @user = Volunteer.new
      @user.email = params[:email]
    end

    def process_login
      if user = Volunteer.authenticate(params[:user])
        session[:id] = user.id # Remember the user's id during this session 
        redirect_to :action => 'my_account'
      else
        flash[:error] = 'Invalid login.' 
        redirect_to :action => 'login', :email => params[:user][:email]
      end
    end 

    def logout
      reset_session
      flash[:message] = 'Logged out.' 
      redirect_to :action => 'login' 
    end

    def my_account
    end

end