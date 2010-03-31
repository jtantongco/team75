class GroupProfilesController < ApplicationController
  # GET /group_profiles
  # GET /group_profiles.xml
  def index
    @group_profiles = GroupProfile.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @group_profiles }
    end
  end

  # GET /group_profiles/1
  # GET /group_profiles/1.xml
  def show
    @group_profile = GroupProfile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group_profile }
    end
  end

  # GET /group_profiles/new
  # GET /group_profiles/new.xml
  def new
    @group_profile = GroupProfile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @group_profile }
    end
  end

  # GET /group_profiles/1/edit
  def edit
    @group_profile = GroupProfile.find(params[:id])
  end

  # POST /group_profiles
  # POST /group_profiles.xml
  def create
    @group_profile = GroupProfile.new(params[:group_profile])

    respond_to do |format|
      if @group_profile.save
        flash[:notice] = 'GroupProfile was successfully created.'
        format.html { redirect_to(@group_profile) }
        format.xml  { render :xml => @group_profile, :status => :created, :location => @group_profile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group_profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /group_profiles/1
  # PUT /group_profiles/1.xml
  def update
    @group_profile = GroupProfile.find(params[:id])

    respond_to do |format|
      if @group_profile.update_attributes(params[:group_profile])
        flash[:notice] = 'GroupProfile was successfully updated.'
        format.html { redirect_to(@group_profile) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group_profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /group_profiles/1
  # DELETE /group_profiles/1.xml
  def destroy
    @group_profile = GroupProfile.find(params[:id])
    @group_profile.destroy

    respond_to do |format|
      format.html { redirect_to(group_profiles_url) }
      format.xml  { head :ok }
    end
  end
end
