module SAccountsHelper
		
  def getSupervisor
		Supervisor.find_by_s_id( session[:sid] )
  end
  
end
