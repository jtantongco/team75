class ProjectsController < ApplicationController
  before_filter :login_required
  
  def provide_feedback
    @project = Project.find_by_p_id(params[:id])
    @project_feedback = @project.project_feedbacks.new
    
    if request.post?
      @project_feedback = @project.project_feedbacks.new(params[:project_feedback])
      @project_feedback.volunteer_id = @user.id
      if @project_feedback.save
        flash[:message] = "[todo: redirect to proper place] Thank you for your feedback!"
        #redirect_to Wherever
      end
    end
  end
end
