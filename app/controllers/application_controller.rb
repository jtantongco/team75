# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  before_filter :set_user, :set_user_s, :set_user_a

  protected
  def set_user
    @user = Volunteer.find(session[:id]) if @user.nil? && session[:id]
  end 

  protected
  def set_user_s
    @s_user = Supervisor.find(session[:sid]) if @s_user.nil? && session[:sid]
  end 
  
  protected
  def set_user_a
    @a_user = Administrator.find(session[:aid]) if @a_user.nil? && session[:aid]
  end 
  

  def login_required
    return true if @user
    access_denied
    return false
  end
  
  def login_required_s
    return true if @s_user
    access_denied_s
    return false
  end
  
  def login_required_a
    return true if @a_user
    access_denied_a
    return false
  end

  def access_denied
    session[:return_to] = request.request_uri
    flash[:error] = 'Oops. You need to login before you can view that page.' 
    redirect_to :controller => 'accounts', :action => 'login'
  end
  
  def access_denied_s
    session[:return_to] = request.request_uri
    flash[:error] = 'Oops. You need to login before you can view that page.' 
    redirect_to :controller => 's_accounts', :action => 'login'
  end
  
  def access_denied_a
    session[:return_to] = request.request_uri
    flash[:error] = 'Oops. You need to login before you can view that page.' 
    redirect_to :controller => 'a_accounts', :action => 'login'
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
