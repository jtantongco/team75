require 'digest/sha1'

class OrientationsController < ApplicationController
  # GET /orientations
  # GET /orientations.xml
  def index
    @orientations = Orientation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orientations }
    end
  end

  # GET /orientations/1
  # GET /orientations/1.xml
  def show
    @orientation = Orientation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @orientation }
    end
  end

  # GET /orientations/new
  # GET /orientations/new.xml
  def new
    @orientation = Orientation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @orientation }
    end
  end

  # GET /orientations/1/edit
  def edit
    @orientation = Orientation.find(params[:id])
  end

  # POST /orientations
  # POST /orientations.xml
  def create
    @orientation = Orientation.new(params[:orientation])

    respond_to do |format|
      if @orientation.save
        flash[:notice] = 'orientation was successfully created.'
        format.html { redirect_to(@orientation) }
        format.xml  { render :xml => @orientation, :status => :created, :location => @orientation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @orientation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orientations/1
  # PUT /orientations/1.xml
  def update
    @orientation = Orientation.find(params[:id])

    respond_to do |format|
      if @orientation.update_attributes(params[:orientation])
        flash[:notice] = 'orientation was successfully updated.'
        format.html { redirect_to(@orientation) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @Orientation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orientations/1
  # DELETE /orientations/1.xml
  def destroy
    @orientation = Orientation.find(params[:id])
    @orientation.destroy

    respond_to do |format|
      format.html { redirect_to(orientations_url) }
      format.xml  { head :ok }
    end
  end
end
