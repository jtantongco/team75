class SelfReportsController < ApplicationController
  before_filter :login_required
  @user = Volunteer.find_by_v_id(session[:id]) if defined? session[:id]
  
  def create_report
    @report = SelfReport.new
    if request.post?
      @report = @user.self_reports.build(params[:self_report])
      if @report.save
        flash[:message] = 'Your hour report has been saved. It will be verified by the supervisor.'
        flash[:message] += "<br />You have been automatically joined to the project \"#{@report.project.name}\"" if @user.join_project(@report.project)
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
        flash[:message] += "<br />You have been automatically joined to the project \"#{@report.project.name}\"" if @user.join_project(@report.project)
        redirect_to :action => :index
      end
    end
  end
  
  # Lists the volunteers reported hours
  def index
    @unverified_reports = @user.self_reports.find(:all, :conditions => "verified = 0") 
    @verified_reports = @user.self_reports.find(:all, :conditions => "verified = 1")
    
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
end
