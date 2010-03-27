require 'digest/sha1'

# Methods added to this helper will be available to all templates in the application.
	
module ApplicationHelper
  def province_options
    [
      ["Alberta", "AB"], 
      ["British Columbia", "BC"], 
      ["Manitoba", "MB"], 
      ["New Brunswick", "NB"], 
      ["Newfoundland and Labrador", "NL"], 
      ["Northwest Territories", "NT"], 
      ["Nova Scotia", "NS"], 
      ["Nunavut", "NU"], 
      ["Ontario", "ON"], 
      ["Prince Edward Island", "PE"], 
      ["Quebec", "QC"], 
      ["Saskatchewan", "SK"], 
      ["Yukon", "YT"]
    ]
  end
  
  # Returns true if the current user is logged in as volunteer
  def volunteer_logged_in?
    session[:id] && session[:volunteer]
  end
  
  # Returns true if the current controller and action are such that the volunteer menu should be printed
  def volunteer_menu?
    cont  = controller.controller_name
    act   = controller.action_name

    volunteer_logged_in? ||
      cont == 'accounts' ||
      cont == 'volunteers'     && (act == 'new') ||
      cont == 'self_reports'   && (act == 'index'           || act == 'create_report' || act == 'edit_report') ||
      cont == 'orientations'   && (act == 'v_orientations'  || act == 'v_register') ||
      cont == 'projects'       && (act == 'index'           || act == 'provide_feedback')
  end
  
  # An extension of the normal link_to method that adds the CSS-class "UbcCurrent" to the link
  # if the linked page is the current one. 
  def menu_link_to(text, options = {})
    if (options[:controller] == controller.controller_name && options[:action] == controller.action_name)
      link_to(text, options, :class => 'UbcCurrent')
    else
      link_to(text, options)
    end
  end
end
