class SelfReportController < ApplicationController
  before_filter :login_required
  @user = Volunteer.find_by_v_id(session[:id]) if defined? session[:id]
  
  def create_report
    @report = SelfReport.new

    if request.post?
      @report = SelfReport.new(params[:self_report])
      @report.volunteer_id = @user.v_id

      if @report.save
        flash[:message] = 'Your hour report has been saved. It will be verified by the supervisor.'
        redirect_to :action => :index
      end
    end
  end
  
  def edit_report
    begin
      @report = @user.self_report.find(params[:id])
    rescue
      flash[:error] = 'Report not found'
      redirect_to :action => :index
    end
    
    if request.put? 
      if @report.update_attributes(params[:self_report])
        flash[:message] = 'Your report has been updated.'
        redirect_to :action => :index
      end
      logger.info 'POST'
    end
  end
  
  # Lists the volunteers reported hours
  def index
    @reports = @user.self_report
  end
  
  
  def delete
    begin
      @report = @user.self_report.find(params[:id])
      @report.destroy
    rescue
      flash[:error] = 'Report not found'
    end
    
    redirect_to :action => :index
  end
end
