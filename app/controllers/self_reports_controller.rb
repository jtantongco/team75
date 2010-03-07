class SelfReportsController < ApplicationController
  def create
    @report = SelfReport.new
    
  end
end
