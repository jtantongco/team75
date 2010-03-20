require 'digest/sha1'

class AccountsController < ApplicationController
  before_filter :login_required, :except => [:login, :process_login, :index, :logout, :forgot_password, :account_created, :reactivate_account]

  @user = Volunteer.find_by_v_id(session[:id]) if defined? session[:id]

  def login
    @user = Volunteer.new
    @user.email = params[:email]

    if request.post?
      user = Volunteer.find_by_email(params[:user][:email]) 
      if user != nil
        if !user.active_status
          flash[:error] = 'Your account is currently deactivated.  You may not proceed until you reactivate it.  If you wish to reactivate your account, please click on "Reactive Account" below and follow the instructions to reactivate your account.'
          redirect_to :action => 'login', :email => params[:user][:email]
        elsif user.password == hash(params[:user][:password])
          session[:volunteer] = true
          session[:id] = user.id # Remember the user's id during this session 
          redirect_to :action => 'my_account'
        else
          flash[:error] = 'Invalid login.'
          redirect_to :action => 'login', :email => params[:user][:email]
        end
      else
        flash[:error] = 'Invalid login.'
        redirect_to :action => 'login', :email => params[:user][:email]
      end
    end
  end 

  def logout
    reset_session
    flash[:message] = 'Logged out.' 
    redirect_to :action => 'login' 
  end

  def my_account
    redirect_to :action => 'deactivated' if @user.active_status == 0
    redirect_to :action => 'not_activated' if !@user.activated
  end

  def sign_contract
    if request.post?
      if params[:accept] == '1'
        @user.update_attribute(:contract_signed, true)
        
        flash[:message] = 'You have successfully signed the Volunteer Contract.'
        redirect_to :action => :my_account
      else
        flash[:error] = 'You forgot to accept the contract.'
      end
    end
  end
  
  def edit_account
    if request.put?
      if @user.update_attributes(params[:volunteer])
        flash[:message] = 'Your account has been updated.'
        redirect_to :action => :my_account
      else
        render :action => "edit_account"
      end
    end
  end

  def change_password
    if request.put?
      old_password = params[:old_password]
      new_password = params[:password]
      confirm_password = params[:password_confirmation]
      if @user.password == hash(old_password)
        if new_password.length > 0 && new_password == confirm_password
          @user.update_attribute("password", hash(new_password))
          flash[:message] = 'Your password has been changed.'
          redirect_to :action => :my_account
        else
          @user.errors.add "New password", "and confirmation password do not match."
        end
      else
        @user.errors.add "Old password", "is invalid"
      end
    end
  end
  
  def forgot_password
    if request.post?
      user = Volunteer.find_by_email(params[:user][:email])
      if user == nil
        flash[:message] = "Sorry we could not find an account associated with that email. Please register for an account first."
      else
        new_pass = random_string(10)
        user.password = hash(new_pass)
        user.save
        Emailer.deliver_forgot_password(user.email, new_pass)
        flash[:message] = "Your request has been received and an email will sent to you shortly.  If you do not find it in your inbox, please check your spam folders."
        redirect_to :action => :login
      end
    end
  end

  def account_created
  end

  def redispatch_activation_code
    user = Volunteer.find_by_v_id(session[:id])
    Emailer.deliver_confirm_email(user.email, user.activation_code)
    flash[:message] = "Your request has been received and an email will be sent to you shortly."
    redirect_to :action => :not_activated
  end

  def verify
    user = Volunteer.find_by_v_id(session[:id])
    if user != nil && user.activation_code == params[:activation_code]
      user.update_attribute(:activated, true)
      flash[:message] = "Account has been successfully activated!"
      redirect_to :action => :my_account
    else
      flash[:error] = "Sorry, please make sure you have entered your activation code correctly."
    end
  end
  
  def deactivate_account
    user = Volunteer.find_by_v_id(session[:id])
    if user != nil
      user.active_status = 0
      user.save
    end
    reset_session
    flash[:message] = 'Your account has been deactivated.' 
    redirect_to :action => 'login' 
  end 
  
  def reactivate_account
    if request.post?
      user = Volunteer.find_by_email(params[:user][:email])
      if user == nil
        flash[:message] = "Sorry we could not find an account associated with that email.  Please check your typing."
      elsif !user.active_status
        user.active_status = 1
        user.save
        flash[:message] = "Your account has now been reactivated.  Please try logging in."
        redirect_to :action => :login
      else
        flash[:message] = "Your account is currently active."
      end
    end
  end
  
  def view_projects
     @projects = Project.all
  end
end