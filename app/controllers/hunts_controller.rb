
class HuntsController < ApplicationController
  before_filter :user_signed_in?, :only => [:edit, :update, :destroy]
  # GET /hunts
  def index
    @hunts = Hunt.all

  end

  # GET /hunts/1
  def show
    @hunt = Hunt.find(params[:id])
    @quiz = Quiz.new
    @quizzes = @hunt.quizzes.order(question_no: :desc)

  end

  # GET /hunts/new
  def new

    @hunt = Hunt.new
    @location = Location.find(params[:location_id])

  end

  # POST /hunts
  def create

    @location = Location.find(params[:location_id])

    @hunt = @location.hunts.build(hunt_params)

    @hunt.user = current_user

    if @hunt.save
      redirect_to new_hunt_quiz_path(@hunt), notice: 'Hunt was successfully created.'
    else

      redirect_to new_location_hunt_path(@location), notice: 'Hunt was not created.'
    end
  end


  def destroy
    @hunt = Hunt.find(params[:id]).destroy
    @quiz = @hunt.quizzes.destroy
    binding.pry
    redirect_to hunts_path, notice: 'Hunt was successfully deleted'
  end


  def edit

     @hunt = Hunt.find(params[:id])

  end

  def update
    @hunt = Hunt.find(params[:id])

    @hunt.update(hunt_params)

    if @hunt.save
      redirect_to @hunt, notice: 'Hunt was successfully updated.'
    else
      render action: 'edit'
    end
  end




  #private

  # Never trust parameters from the scary internet, only allow the white list through.
  def hunt_params
    params.require(:hunt).permit(:name, :category, :description, :user_id, :location_id)
  end

  def user_signed_in?
    redirect_to root_path unless current_user
  end
end
