class ProjectsController < ApplicationController
  before_filter :login_required
  helper :projects

  def index
    user = Volunteer.find_by_v_id(session[:id])
    if user != nil
        @volunteers_projects = VolunteersProjects.find(:all, :conditions => { :volunteer_id => user.v_id })
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
        @volunteers_projects = VolunteersProjects.find(:all, :conditions => { :volunteer_id => user.v_id })
        
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
                    
                if vp.project_id == p.p_id
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
  	
  	@vp = VolunteersProjects.new
  	@vp.volunteer_id = session[:id]
  	@vp.project_id = params[:project]
  	
  	 if @vp.save
        flash[:message] = 'Successfully joined '+project.name+'!'
        redirect_to :action => :join_projects
     else
      	flash[:message] = 'Error:  Could not join project!'
        render :action => :join_projects
     end
  end
  
  def leave
  	@vp = VolunteersProjects.find_by_project_id_and_volunteer_id(params[:p_id], params[:v_id])

	@sql = "DELETE FROM volunteers_projects WHERE volunteer_id = "+@vp.volunteer_id.to_s+" AND project_id = "+@vp.project_id.to_s
	ActiveRecord::Base.connection.execute(@sql)

	flash[:message] = 'Removed '+ params[:name]
    redirect_to :action => :index
  end
 
end
