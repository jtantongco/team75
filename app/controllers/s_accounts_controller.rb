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
  
  def logout
    reset_session
    flash[:message] = 'Logged out.' 
    redirect_to :action => 'login' 
  end
  
  def delete
    begin
      @s_report = @own_reports.find(params[:id])
      @s_report.destroy
    rescue
      flash[:error] = 'Report not found'
    end
    
    redirect_to :action => :verify_reports
  end
  
  def accept
  	begin
  	  @s_report = SelfReport.find(params[:id])
  	  @s_report.verified = true
  	  @s_report.save
  	rescue
      flash[:error] = 'Report not found'
    end
    
    redirect_to :action => :verify_reports
  end
  
  def acceptall
  	@own_report = SelfReport.find(:all, :conditions => {:supervisor_id => session[:sid], :verified => false})
  	begin
  	  @own_report.each { |o_r| 
  	  
  	  o_r.verified = true
  	  o_r.save
  	  }
  	 
  	rescue
      flash[:error] = 'Report not found'
    end
    
    redirect_to :action => :verify_reports
  end
  
  def verify_reports
  #	@own_reports = SelfReport.all
  #	@own_reports = SelfReport.find_by_supervisor_id([params[:sid]])
	@own_reports = SelfReport.find(:all, :conditions => {:supervisor_id => session[:sid], :verified => false})
  	flash[:message] = 'There are ' + @own_reports.count.to_s + ' unverified self-reports.'
  end
  
end