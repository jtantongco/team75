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
        render :action => "edit_account"
      end
    end
    
    def report_hours
      @user = Volunteer.find_by_v_id(session[:id])
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