class SAccountsController < ApplicationController
	before_filter :login_required_s, :except => [:login, :index, :logout]
    
  @s_user = Supervisor.find_by_s_id(session[:sid]) if defined? session[:sid]    
    
  def login
    @s_user = Supervisor.new
    # @s_user.login_name = params[:login_name]

    if request.post?
      @s_user = Supervisor.find_by_login_name(params[:s_user][:login_name]) 

      if @s_user != nil
        if @s_user.password == params[:s_user][:password]
          session[:supervisor] = true
          session[:sid] = @s_user.s_id # Remember the user's id during this session 
          redirect_to :action => :my_account
        else
          flash[:error] = 'Invalid login.'
        end
      else
        flash[:error] = 'Invalid login.'
      end
    end
  end 

  def my_account
    @supervisor = @s_user
	  @own_reports = SelfReport.find(:all, :conditions => {:supervisor_id => session[:sid], :verified => false})
  	flash.now[:message] = 'There are ' + @own_reports.count.to_s + ' unverified self-reports. 
  	  Please verify them <a href="' + url_for(:action => :verify_reports) + '">here</a>.'
  end
  
  def logout
    reset_session
    flash[:message] = 'Logged out.' 
    redirect_to :action => 'login' 
  end
  
  def reject_comment
  	if request.post?
  	  @s_report = SelfReport.find(params[:id])
      @v_user = Volunteer.find_by_v_id(@s_report.volunteer_id)
      @comment = params[:tempo][:comment]
      
        if @v_user == nil
      	  @s_report.destroy
      	  flash[:error] = 'The report has been rejected but a notification e-mail could not be sent: Volunteer not found or currently not active'
        else
          
          Emailer.deliver_rejection_notification(@v_user.email, @s_report.date, @s_report.project.name, @s_report.supervisor.name, @s_report.hours, @s_report.task_description, @comment)
         
            redirect_to :action => 'verify_reports'
          	@s_report.destroy
            flash[:error] = 'The report has been rejected and a notification e-mail has been successfully sent.'
          
        end
    end
  end
 
  
  
  
  def edit_reports
  	begin
      @temp_reports = SelfReport.find(params[:id])
      
    rescue
      flash[:error] = 'Report not found'
      redirect_to :action => :verify_reports
    end
    
      @v_use = Volunteer.find_by_v_id(@temp_reports.volunteer_id)
      if @v_use == nil
      	flash[:error] = 'Volunteer not found or currently not active'
        redirect_to :action => 'verify_reports'
      else
    
  		if request.post?
           @temp_reports.update_attributes(params[:self_report])
    
          flash[:error] = 'The report has been updated.'
          redirect_to :action => :verify_reports
      
        end
      end
  	
  end
  
  
  
  
  
  
  def accept
  	begin
  	  @s_report = SelfReport.find(params[:id])
  	  @s_report.verified = true
  	  @s_report.save
  	rescue
      flash[:error] = 'Report not found'
    end
    flash[:error] = 'Report has been verified'
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
    flash[:error] = 'All reports have been verified'
    redirect_to :action => :verify_reports
  end
  
  def verify_reports
  #	@own_reports = SelfReport.all
  #	@own_reports = SelfReport.find_by_supervisor_id([params[:sid]])
	@own_reports = SelfReport.find(:all, :conditions => {:supervisor_id => session[:sid], :verified => false})
  end
  
  
  def create_reports_volunteer
  	@tempo_report = SelfReport.new
    if request.post?
      
      @tempo_report.update_attributes(params[:self_report])
      @tempo_report.verified = true
        
        join_project()
        @tempo_report.save
        
        redirect_to :action => :my_account
        flash[:error] = 'Hour report has been created.'
     
    end
  end
  
  
  
  def create_reports_group
  	
  end
  
  
  
  protected
  # Checks if the current user has joined the project s/he associated with the report
  # If s/he has not joined the project, s/he is automatically joined to it.
  def join_project()
  	@tempo_user = Volunteer.find_by_v_id(@tempo_report.volunteer_id)
    if (!@tempo_user.projects.exists?(@tempo_report.project))
      @tempo_user.projects << @tempo_report.project
    end
  end
  
  
  
  
end