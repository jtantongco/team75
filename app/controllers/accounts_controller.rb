class AccountsController < ApplicationController
    before_filter :login_required, :except => [:login, :process_login, :index, :logout, :forgot_password]
    
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

    def edit_account
      @user = Volunteer.find_by_v_id(session[:id])
    end
    
    def update_account
      @user = Volunteer.find_by_v_id(session[:id])
      if @user.update_attributes(params[:volunteer])
        flash[:message] = '[[todo, validate data and save]] Your account has been updated.'
        redirect_to :action => :my_account
      else
        flash[:error] = 'You did not enter the form correctly. Please fix any errors!'
        render :action => "edit_account"
      end
    end
    
    def forgot_password
      if request.post?
        user = Volunteer.find_by_email(params[:user][:email])
        if user == nil
          flash[:message] = "Sorry we could not find an account associated with that email. Please register for an account first."
        else
          Emailer.deliver_forgot_password(user.email, user.password)
          flash[:message] = "Your request has been received and an email will sent to you shortly.  If you do not find it in your inbox, please check your spam folders."
        end
      end
    end
end