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
end
