class GroupReportsController < ApplicationController
  # GET /group_reports
  # GET /group_reports.xml
  def index
    @group_reports = GroupReport.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @group_reports }
    end
  end

  # GET /group_reports/1
  # GET /group_reports/1.xml
  def show
    @group_report = GroupReport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group_report }
    end
  end

  # GET /group_reports/new
  # GET /group_reports/new.xml
  def new
    @group_report = GroupReport.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @group_report }
    end
  end

  # GET /group_reports/1/edit
  def edit
    @group_report = GroupReport.find(params[:id])
  end

  # POST /group_reports
  # POST /group_reports.xml
  def create
    @group_report = GroupReport.new(params[:group_report])

    respond_to do |format|
      if @group_report.save
        flash[:notice] = 'GroupReport was successfully created.'
        format.html { redirect_to(@group_report) }
        format.xml  { render :xml => @group_report, :status => :created, :location => @group_report }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group_report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /group_reports/1
  # PUT /group_reports/1.xml
  def update
    @group_report = GroupReport.find(params[:id])

    respond_to do |format|
      if @group_report.update_attributes(params[:group_report])
        flash[:notice] = 'GroupReport was successfully updated.'
        format.html { redirect_to(@group_report) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group_report.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /group_reports/1
  # DELETE /group_reports/1.xml
  def destroy
    @group_report = GroupReport.find(params[:id])
    @group_report.destroy

    respond_to do |format|
      format.html { redirect_to(group_reports_url) }
      format.xml  { head :ok }
    end
  end
end
