class SelfReportController < ApplicationController
  def create_report
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
  
  # Lists the volunteers reported hours
  def index
    
  end
end
