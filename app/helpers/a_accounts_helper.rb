module AAccountsHelper
			
  def getAdministrator
		Administrator.find_by_a_id( session[:aid] )
  end
  
end
