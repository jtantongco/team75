class RewardProfilesController < ApplicationController
  # GET /reward_profiles
  # GET /reward_profiles.xml
  def index
    @reward_profiles = RewardProfile.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reward_profiles }
    end
  end

  # GET /reward_profiles/1
  # GET /reward_profiles/1.xml
  def show
    @reward_profile = RewardProfile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reward_profile }
    end
  end

  # GET /reward_profiles/new
  # GET /reward_profiles/new.xml
  def new
    @reward_profile = RewardProfile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reward_profile }
    end
  end

  # GET /reward_profiles/1/edit
  def edit
    @reward_profile = RewardProfile.find(params[:id])
  end

  # POST /reward_profiles
  # POST /reward_profiles.xml
  def create
    @reward_profile = RewardProfile.new(params[:reward_profile])

    respond_to do |format|
      if @reward_profile.save
        flash[:notice] = 'RewardProfile was successfully created.'
        format.html { redirect_to(@reward_profile) }
        format.xml  { render :xml => @reward_profile, :status => :created, :location => @reward_profile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reward_profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reward_profiles/1
  # PUT /reward_profiles/1.xml
  def update
    @reward_profile = RewardProfile.find(params[:id])

    respond_to do |format|
      if @reward_profile.update_attributes(params[:reward_profile])
        flash[:notice] = 'RewardProfile was successfully updated.'
        format.html { redirect_to(@reward_profile) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reward_profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reward_profiles/1
  # DELETE /reward_profiles/1.xml
  def destroy
    @reward_profile = RewardProfile.find(params[:id])
    @reward_profile.destroy

    respond_to do |format|
      format.html { redirect_to(reward_profiles_url) }
      format.xml  { head :ok }
    end
  end
  
   def s_showRewards
	@reward_profile = RewardProfile.find(params[:id])
   
	@rewards = Reward.find(:all, :conditions => {:RPid => params[:id]})
  end
end
