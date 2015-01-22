
class HuntsController < ApplicationController
  before_action :authenticate_user!, :only => [:edit, :update, :destroy]

  def index
   @hunts = Hunt.all
  end

  def show
    @hunt = Hunt.find(params[:id])
    @location = @hunt.location
    @questionsets = @hunt.questionsets.order(question_no: :desc)
  end

  def new
    @hunt = Hunt.new
    @location = Location.find(params[:location_id])
  end

  def create

    @location = Location.find(params[:location_id])
    @hunt = @location.hunts.build(hunt_params)
    @hunt.user = current_user

    if @hunt.save
      redirect_to location_hunt_path(@location, @hunt), notice: 'Hunt was successfully created.'
    else
      redirect_to new_location_hunt_path(@location), notice: 'Hunt was not created.'
    end

  end

  def destroy
   @hunt= Hunt.find(params[:id])
    @location = @hunt.location

    if @hunt.destroy
      redirect_to location_path(@location), notice: "Hunt successfully deleted"
    else
      flash[:notice] = "Hunt was not deleted"
      render 'show'
    end

  end


  def edit
     @hunt = Hunt.find(params[:id])
     @location = @hunt.location
  end

  def update
    @hunt = Hunt.find(params[:id])
    @location = @hunt.location
    @hunt.update(hunt_params)

    if @hunt.save
      redirect_to location_hunt_path(@location, @hunt), notice: 'Hunt was successfully updated.'
    else
      flash[:notice] = 'Hunt was not updated.'
      render action: 'edit'
    end

  end

  def hunt_params
    params.require(:hunt).permit(:name, :category, :description, :user_id, :location_id)
  end


end
