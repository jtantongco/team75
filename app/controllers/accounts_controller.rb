require 'digest/sha1'

class AccountsController < ApplicationController
    before_filter :login_required, :except => [:login, :process_login, :index, :logout, :forgot_password]
    

    def login
      @user = Volunteer.new
      @user.email = params[:email]
    end

    def process_login
      #if user = Volunteer.authenticate(params[:user])
      user = Volunteer.find_by_email(params[:user][:email]) 
      if user != nil
          if user.password == hash(params[:user][:password])
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

    def logout
      reset_session
      flash[:message] = 'Logged out.' 
      redirect_to :action => 'login' 
    end

    @user = Volunteer.find_by_v_id(session[:id]) if defined? session[:id]

    def my_account
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
    
    def report_hours
      @report = SelfReport.new
      
      if request.post?
        @report = SelfReport.new(params[:self_report])
        @report.volunteer_id = @user.v_id

        if @report.save
          flash[:message] = '[todo: redirect to report list] Your hour report has been saved. It will be verified by the supervisor.'
          redirect_to :action => :my_account
        else
          render :action => :report_hours
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
        end
      end
    end
    
    #generates a random password consisting of strings and digits
    def random_string(len)
      chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      newpass = ""
      1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
      return newpass
    end
    
    def hash (str)
      return Digest::SHA1.hexdigest(str)
    end
end