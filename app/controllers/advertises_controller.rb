class AdvertisesController < ApplicationController

  before_filter :init_params, :only => [:create, :update]

  def index
    @advertises = Advertise.order(:time.desc)
    #@advertises = Advertise.paginate(page: params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @advertise }
    end
  end


  def show
    @advertise = Advertise.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @advertise }
    end
  end

  def new
    @advertise = Advertise.new
  end


  def edit
    @advertise = Advertise.find(params[:id])
  end


  def create
    params[:advertise][:time] = DateTime.new(params[:advertise]["time(1i)"].to_i, params[:advertise]["time(2i)"].to_i,
                                            params[:advertise]["time(3i)"].to_i, params[:advertise]["time(4i)"].to_i,
                                            params[:advertise]["time(5i)"].to_i).to_i
    @advertise = Advertise.new(params[:advertise])

    respond_to do |format|
      if @advertise.save
        format.html { redirect_to :action => :index, :notice => 'Advertise was successfully created.' }
        format.json { render :json => @advertise, :status => :created, :location => @advertise }
      else
        format.html { render :action => "new" }
        format.json { render :json => @advertise.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @advertise = Advertise.find(params[:id])

    respond_to do |format|
      if @advertise.update_attributes(params[:advertise])
        format.html { redirect_to @advertise, :notice => 'Advertise was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @advertise.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @advertise = Advertise.find(params[:id])
    @advertise.destroy

    respond_to do |format|
      format.html { redirect_to advertises_path }
      format.json { head :no_content }
    end
  end
  def set_adveradtise
    @advertises= Advertise.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def advertise_params
    params.require(:advertises).permit(:title, :picture,:description,:package,:state,:time,:type)
  end

  def init_params
    file_obj = params[:advertise][:picture]
    if !file_obj.nil? && !file_obj.original_filename.empty?
      pic_path = "/upload/#{file_obj.original_filename}"
      params[:advertise][:picture] = pic_path

      File.open(Rails.root.to_s + "/public" + pic_path, "wb") do |f|
        f.write(file_obj.read)
      end
    end
  end
  end


