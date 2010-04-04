require 'digest/sha1'
require 'app/models/volunteers_orientation.rb'

class OrientationsController < ApplicationController
  # GET /orientations
  # GET /orientations.xml
  def index
    @orientations = Orientation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orientations }
    end
  end

  # GET /orientations/1
  # GET /orientations/1.xml
  def show
    @orientation = Orientation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orientation }
    end
  end

  # GET /orientations/new
  # GET /orientations/new.xml
  def new
    @orientation = Orientation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @orientation }
    end
  end

  # GET /orientations/1/edit
  def edit
    @orientation = Orientation.find(params[:id])
  end

  # POST /orientations
  # POST /orientations.xml
  def create
    @orientation = Orientation.new(params[:orientation])

    if @orientation.save
        redirect_to :action => :index
    end
  end

  # PUT /orientations/1
  # PUT /orientations/1.xml
  def update
    @orientation = Orientation.find(params[:id])

    respond_to do |format|
      if @orientation.update_attributes(params[:orientation])
        flash[:notice] = 'orientation was successfully updated.'
        format.html { redirect_to(@orientation) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @Orientation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orientations/1
  # DELETE /orientations/1.xml
  # DELETE /orientations/1
  # DELETE /orientations/1.xml
  def destroy
    @orientation = Orientation.find(params[:id])
    if @orientation != nil
    	@sql = "DELETE FROM volunteers_orientations WHERE orientation_id = "+@orientation.o_id.to_s
		ActiveRecord::Base.connection.execute(@sql)
		@orientation.destroy
		flash[:success] = 'Successfully destroyed all attendees for '+@orientation.name+' as well as '+@orientation.name+'!'
	else 
		flash[:error] = 'Orientation could not be found. Please try again or contact the System Administrator.'
	end
	redirect_to :action => :index
  end
  
  def v_orientations
    user = Volunteer.find_by_v_id(session[:id])
    if user != nil
        @volunteers_orientations = VolunteersOrientation.find(:all, :conditions => { :volunteer_id => user.v_id })
        @volunteers_orientations = removePastOrientations( @volunteers_orientations )
    else 
        redirect_to :action => :index
    end
  end
  
  def v_register
    user = Volunteer.find_by_v_id(session[:id])
    if user != nil
    	
    	# Find all orientations that volunteer is registered in
        @volunteers_orientations = VolunteersOrientation.find(:all, :conditions => { :volunteer_id => user.v_id })
        
        # Get all orientations
        @orientations_all = Orientation.all
        
        # Array to hold the orientations that the volunteer has not registered for
        @orien_view = Array.new
        
        # For each orientation
        @orientations_all.each { |o|
            
            # Variable to hold whether this orientation is already registered by volunteer, default = false
            is_registered = false
            
            # Check to see if orientation is already registered, if so, is_registered turns true
            @volunteers_orientations.each { |ov|
                    
                if ov.orientation_id == o.o_id
                    is_registered = true
                end
            }

            if !is_registered && Time.now < o.start_time
                @orien_view.push(o)
            end
        }
        
    	# @orien_view = removePastOrientations( @orien_view )
    else
        redirect_to :action => :index
    end
        
  end
  
  def v_add_orientation
  	orientation = Orientation.find_by_o_id(params[:orien])
  	
  	@orien_vol = VolunteersOrientation.new
  	@orien_vol.volunteer_id = session[:id]
  	@orien_vol.orientation_id = params[:orien]
  	@orien_vol.attended = false
  	
  	if @orien_vol.save
        flash[:message] = 'Successfully registered for '+orientation.name+'!'
        redirect_to :action => :v_register
      else
      	flash[:message] = 'Something went wrong with the v_add_orientation method :('
        render :action => :v_register
     end
  end
  
  def v_cancle
  	
  	@vo = VolunteersOrientation.find_by_orientation_id_and_volunteer_id(params[:o_id], params[:v_id])

	@sql = "DELETE FROM volunteers_orientations WHERE volunteer_id = "+@vo.volunteer_id.to_s+" AND orientation_id = "+@vo.orientation_id.to_s
	ActiveRecord::Base.connection.execute(@sql)

	flash[:message] = 'Removed '+ params[:name]
    redirect_to :action => :v_orientations
  end

  def showAttendees
	@orientation = Orientation.find(params[:id])
	@attendees = VolunteersOrientation.find(:all, :conditions => {:orientation_id => params[:id]})
	@volunteers = Volunteer.all
	
	@attendee_view = Array.new
	
	@attendees.each{ |a|
		@volunteers.each{ |v|
			if a.volunteer_id == v.v_id
				@attendee_view.push([v.name, a.attended, a.orientation_id, a.volunteer_id])
				break
			end
		}	
	}
  end

  def s_confirmAttendance
	@vo = VolunteersOrientation.find_by_orientation_id_and_volunteer_id(params[:o_id], params[:v_id])

	@sql = "UPDATE volunteers_orientations SET attended = '1' WHERE volunteer_id = "+@vo.volunteer_id.to_s+" AND orientation_id = "+@vo.orientation_id.to_s
	ActiveRecord::Base.connection.execute(@sql)

	flash[:message] = params[:name] + ' has been marked as attended.'
    redirect_to :action => :showAttendees, :id => @vo.orientation_id
  end
  
   def s_cancelAttendance
  	
  	@vo = VolunteersOrientation.find_by_orientation_id_and_volunteer_id(params[:o_id], params[:v_id])

	@sql = "DELETE FROM volunteers_orientations WHERE volunteer_id = "+@vo.volunteer_id.to_s+" AND orientation_id = "+@vo.orientation_id.to_s
	ActiveRecord::Base.connection.execute(@sql)

	flash[:message] = 'Removed '+ params[:name]
	redirect_to :action => :showAttendees, :id => params[:o_id]
  end
  
  protected
  def removePastOrientations ( vo )
  	
  	theVo = vo
  	returnee = Array.new
  	theVo.each{ |von| 
  	
  		orien = Orientation.find_by_o_id( von.orientation_id )
  		if Time.now < orien.start_time
  			returnee.push( von )
  		end
  	
  	}
  	returnee
  end
end
