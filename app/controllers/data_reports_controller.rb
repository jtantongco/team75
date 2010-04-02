class DataReportsController < ApplicationController
	before_filter :login_required_a
   
  def volunteer_report
  	
  	v_start = params[:v_start]
  	v_end = params[:v_end]
  	
    @volunteers_all = Volunteer.all
  	file = File.new("reports/VolunteerReport - "+Time.now.to_i.to_s+".txt", "w")

  	@volunteers = Array.new
  	# avg age of volunteers
  	sum = 0
  	@volunteers_all.each{ |vol| if vol.created_at.year >= v_start.to_i && vol.created_at.year <= v_end.to_i 
  							   sum = sum + (Time.now.year - vol.birthday.year)
  							   @volunteers.push(vol)
  							end }
  							
  	if @volunteers.size != 0
	  	avg_age = sum.to_f/@volunteers.size
	  	
	  	file.puts("Generated report for "+@volunteers.size.to_s+" volunteers"+"from year "+v_start.to_s+" to year "+v_end)
	  	file.puts("")
	  	file.puts("-------------------------------------------------------------------")
	  	file.puts("")
	  	file.puts("Avg age of volunteers: "+avg_age.to_i.to_s)
	  	file.puts("Number of student volunteers: "+Student.all.size.to_s)
	  	file.puts("Number of non-student is "+(@volunteers.size-Student.all.size).to_s)
	  	
	  	file.close
	  	
	  	flash[:message] = "Volunteers report successfully generated"
  	else
  		flash[:message] = "No volunteers were found in the date range specified"
  	end
  	redirect_to :action =>  :index

  end 

  def projects_report
  	@projects = Project.all
  	file = File.new("reports/ProjectReport - "+Time.now.to_i.to_s+".txt", "w")
  	file.puts("Generated report for "+@projects.size.to_s+" projects")
  	
  	@projects.each{ |p|
  	
  		@self_reports = SelfReport.find(:all, :conditions => { :project_id => p.p_id, :verified => true })
  	    time_total = 0
  	    @self_reports.each{ |r| time_total = time_total + (r.end_time - r.start_time) }
  		time_total = time_total.to_f / 3600
  		
  		@vols = SelfReport.find(:all, :select => 'DISTINCT volunteer_id', :conditions => { :project_id => p.p_id })
  		file.puts("")
  		file.puts("--------------------------------------------------------------------")
  		file.puts("Report for project: "+p.name)
  		file.puts("Total hours reported for this project: "+time_total.to_s)
  		file.puts("Total self reports for this project: "+@self_reports.size.to_s)
  		file.puts("Number of distinct volunteers that reported hours for this project: "+@vols.size.to_s)
  		file.puts("Average number of hours reported per volunteer: "+(time_total.to_f/@vols.size).to_s)
  		file.puts("")  	
  			
  	}
  	file.close
  	flash[:message] = "Projects report successfully generated"
  	redirect_to :action => :index
  end
  
  def index
  end
  
end
