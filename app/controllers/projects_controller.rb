class ProjectsController < ApplicationController
  before_filter :login_required
  helper :projects

  def index
    user = Volunteer.find_by_v_id(session[:id])
    if user != nil
      #@volunteers_projects = VolunteersProjects.find(:all, :conditions => { :volunteer_id => user.v_id })
      @volunteers_projects = user.projects
    end
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

  def join_projects
    user = Volunteer.find_by_v_id(session[:id])
    if user != nil
      # Find all projects that the volunteer joined
      #@volunteers_projects = VolunteersProjects.find(:all, :conditions => { :volunteer_id => user.v_id })
      @volunteers_projects = user.projects
      
      # Get all projects
      @projects = Project.all

      # Array to hold the projects that the volunteer has joined
      @projects_view = Array.new

      # For all projects check if the volunteer has joined it or not
      @projects.each { |p|

        # Variable to hold whether this project is already joined by volunteer, default = false
        is_registered = false

        # Check to see if project is already joined, if so, is_registered turns true
        @volunteers_projects.each { |vp|

          if vp.p_id == p.p_id
            is_registered = true
          end
        }

        if !is_registered && p.status == "active"
          @projects_view.push(p)
        end
      }
    end
  end

  def join
    project = Project.find_by_p_id(params[:project])
    user = Volunteer.find_by_v_id(session[:id])

    if user.join_project(project)
      flash[:message] = 'Successfully joined '+project.name+'!'
    else
      flash[:message] = 'Error: Could not join the project! Maybe you have already joined it?'
    end
    redirect_to :action => :join_projects
  end

  def leave
    user = Volunteer.find_by_v_id(session[:id])
    user.projects.delete(Project.find_by_p_id(params[:p_id]))

    flash[:message] = 'Removed '+ params[:name]
    redirect_to :action => :index
  end

end
