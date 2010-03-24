class ProjectsController < ApplicationController
  before_filter :login_required

  def index
     @projects = Project.all
  end
  
  def provide_feedback
    begin
      @project = Project.find_by_p_id(params[:id])
      @project_feedback = @project.project_feedbacks.new
    rescue
      flash[:error] = 'Project not found'
      redirect_to :action => :index
    end
    
    if request.post?
      @project_feedback = @project.project_feedbacks.new(params[:project_feedback])
      @project_feedback.volunteer_id = @user.id
      if @project_feedback.save
        flash[:message] = "Thank you for your feedback!"
        redirect_to :action => :index
      end
    end
  end
end
