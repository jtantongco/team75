class SelfReportsController < ApplicationController
  before_filter :login_required
  @user = Volunteer.find_by_v_id(session[:id]) if defined? session[:id]
  
  def create_report
    @report = SelfReport.new
    if request.post?
      @report = @user.self_reports.build(params[:self_report])
      if @report.save
        flash[:message] = 'Your hour report has been saved. It will be verified by the supervisor.'
        join_project()
        redirect_to :action => :index
      end
    end
  end
  
  def edit_report
    begin
      @report = @user.self_reports.find(params[:id])
    rescue
      flash[:error] = 'Report not found'
      redirect_to :action => :index
    end
    
    if request.put? 
      if @report.update_attributes(params[:self_report])
        flash[:message] = 'Your report has been updated.'
        join_project()
        redirect_to :action => :index
      end
    end
  end
  
  # Lists the volunteers reported hours
  def index
    @reports = @user.self_reports
  end
  
  def delete
    begin
      @report = @user.self_reports.find(params[:id])
      @report.destroy
    rescue
      flash[:error] = 'Report not found'
    end
    
    redirect_to :action => :index
  end
  
  def rapid_entry
  	@report = SelfReport.new
  	
  	if request.post?
	  	@report = @user.self_reports.build(params[:self_report])
	  	@volunteer = Volunteer.find_by_email(params[:user][:email])
	  	  
	  	if @volunteer != nil && @report != nil
	  	  if @report.save
		  	flash[:message] = 'Your hour report has been saved. It will be verified by the supervisor.'
		    redirect_to :action => :rapid_entry
	      end
	  	else
	  	  flash[:error] = 'Volunteer not found.  Please make sure you correctly put in your email'	
	  	end
  	end
  end



  protected
  # Checks if the current user has joined the project s/he associated with the report
  # If s/he has not joined the project, s/he is automatically joined to it.
  def join_project()
    if (!@user.projects.exists?(@report.project))
      @user.projects << @report.project
      flash[:message] += "<br />You have been automatically joined to the project \"#{@report.project.name}\""
    end
  end
  
end
