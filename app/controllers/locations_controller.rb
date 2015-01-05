class LocationsController < ApplicationController

  before_action :authenticate_user!, only: [:destroy, :delete, :new, :create, :edit, :update]

  # GET /questions
  def index

    @locations = Location.all
    @location_array = []

    @locations.each do|loc|
       @location_array << [loc.latitude, loc.longitude]
    end

    @location_zoom = 4

    @flag = 1
    @mapcenterlat = 39.8282
    @mapcenterlong = -98.5795
  end

  # GET /questions/1
  def show

    @location = Location.find(params[:id])

    @hunts = @location.hunts

  end

  # GET /questions/new
  def new
    @location = Location.new
    @locations = Location.all

  end

  def redirect_new_hunt

     redirect_to new_location_hunt_path(params[:location][:id])
  end
  # POST /questions
  def create
    address = params[:location][:address]
    id = params[:location][:id]
    flag = true
    if address == '' or address == nil
      flag = false
    else
      @checklocation = Location.where("address=?", address)
      if @checklocation.empty? == false
        flag = false
      end
    end



    if flag == true
      @location= Location.create(location_params)

      @locations = Location.all

      if @location.save
        redirect_to new_location_path, notice: 'Location was successfully created.'
      else
        render action: 'new'
      end
    else

      #redirect_new_hunt
    end
  end


  def destroy

    @location = Location.find(params[:id]).destroy
    redirect_to @location, notice: 'Location was successfully deleted'
  end


  def edit

     @location = Location.find(params[:id])

  end

  def update
    @location = Location.find(params[:id])


    @location.update(question_params)


    if @location.save
      redirect_to @location, notice: 'Location was successfully created.'
    else
      render action: 'edit'
    end
  end


  # GET /questions/search
  def search
    query = "%#{params[:query]}%"
    @questions = Location.where('title like ? or description like ? or url like ?',
             query, query, query)
  end


  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def location_params
    params.require(:location).permit(:latitude, :longitude, :address)
  end


end
