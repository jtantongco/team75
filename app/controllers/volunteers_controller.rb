require 'digest/sha1'

class VolunteersController < ApplicationController

  def hash (str)
    return Digest::SHA1.hexdigest(str)
  end

  # GET /volunteers
  # GET /volunteers.xml
  def index
    @volunteers = Volunteer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @volunteers }
    end
  end

  # GET /volunteers/1
  # GET /volunteers/1.xml
  def show
    @volunteer = Volunteer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @volunteer }
    end
  end

  # GET /volunteers/new
  # GET /volunteers/new.xml
  def new
    @volunteer = Volunteer.new
    @volunteer_extra = VolunteerExtra.new
    @student = Student.new
    @active_projects = Project.find(:all)
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @volunteer }
    end
  end

  # GET /volunteers/1/edit
  def edit
    @volunteer = Volunteer.find(params[:id])
  end

  # POST /volunteers
  # POST /volunteers.xml
  def create
    @active_projects = Project.find(:all)
    @volunteer = Volunteer.new(params[:volunteer])
    @volunteer.build_volunteer_extra(params[:volunteer_extra])
    @volunteer.activation_code = hash(@volunteer.email)
    @volunteer.activated = 0

    if params[:is_student]
      @volunteer.build_student(params[:student])
    end

    respond_to do |format|
      if @volunteer.save
        @volunteer.update_attribute("password", hash(@volunteer.password))  

        dispatch_confirmation( @volunteer )       

        params[:project_interests].each do |project_id|
          project = Project.find_by_p_id(project_id)
          @volunteer.projects << project if project
        end
        
        flash[:success] = "Your account has been successfully created! We have sent an email to you with instructions on how to verify your account registration."
        format.html { redirect_to :controller => 'accounts', :action => 'verify' }
        format.xml  { render :xml => @volunteer, :status => :created, :location => @volunteer }
      else
        @volunteer_extra = @volunteer.volunteer_extra
        @student = @volunteer.student
        if !@student
          @student = Student.new
        end
        format.html { render :action => "new" }
        format.xml  { render :xml => @volunteer.errors, :status => :unprocessable_entity }
      end
    end
  end

  def dispatch_confirmation( volunteer )
    Emailer.deliver_confirm_email( volunteer.email, volunteer.activation_code )
  end

  # PUT /volunteers/1
  # PUT /volunteers/1.xml
  def update
    @volunteer = Volunteer.find(params[:id])

    respond_to do |format|
      if @volunteer.update_attributes(params[:volunteer])
        flash[:notice] = 'Volunteer was successfully updated.'
        format.html { redirect_to(@volunteer) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @volunteer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /volunteers/1
  # DELETE /volunteers/1.xml
  def destroy
    @volunteer = Volunteer.find(params[:id])
    @volunteer.destroy

    respond_to do |format|
      format.html { redirect_to(volunteers_url) }
      format.xml  { head :ok }
    end
  end
end
