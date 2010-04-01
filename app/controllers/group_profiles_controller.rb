class GroupProfilesController < ApplicationController
  before_filter :login_required_s

  def index
    @group_profiles = GroupProfile.find_all_by_deleted(false)
  end

  def new
    @group_profile = GroupProfile.new(params[:group_profile])
    if request.post?
      if @group_profile.save
        flash[:success] = 'Group profile successfully created'
        redirect_to :action => :index
      end
    end
  end

  def edit
    @group_profile = GroupProfile.find(params[:id])
    if request.put?
      if @group_profile.update_attributes(params[:group_profile])
        flash[:success] = 'Your changes have been saved'
        redirect_to :action => :index
      end
    end
  end

  def delete
    @group_profile = GroupProfile.find(params[:id])
    @group_profile.deleted = true
    @group_profile.save

    flash[:success] = 'Group profile removed'
    redirect_to :action => :index
  end
end
