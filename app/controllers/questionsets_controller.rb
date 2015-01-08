
class QuestionsetsController < ApplicationController
  before_action :authenticate_user!, :only => [:show, :edit, :update, :destroy]
  # GET /quizzes
  def index

  end

  # GET /quizzes/1
  def show
    @hunt = Hunt.find(params[:hunt_id])
    @questionset = Questionset.find(params[:id])

    @flm = 0
    @msg = "Let's go..."

    @itinerary = @questionset.upto

    if params[:address] != nil
      @msg = @questionset.check_answer(params[:address][:address])

=begin
      @flm = @questionset.is_answer?(params[:address][:address])

      if @flm == 0

        if @questionset.get_nonmatch == 'dist'

          dist = @questionset.get_distance(params[:address][:address]).round(1)
          @msg = " Sorry, you are about #{dist} miles off, try again"
        else
           @msg = "Sorry, try again"
        end
      else
         @msg = "Great job on guessing #{@questionset.address.split(',').first}.
         #{5 - @questionset.question_no} questions to go "
      end
=end
    end



  end

  # GET /quizzes/ne
  def new

    @questionset = Questionset.new
    @hunt = Hunt.find(params[:hunt_id])

  end

  # POST /quizzes
  def create
    @hunt = Hunt.find(params[:hunt_id])

    @questionset = @hunt.questionsets.build(quiz_params)
    @last_quiz = Questionset.where("hunt_id=?", @hunt.id)

    if @last_quiz == nil || @last_quiz.empty?
      @questionset.question_no = 1
    else
      @questionset.question_no = @last_quiz.last.question_no + 1
    end

    if @questionset.save

      if @questionset.question_no < 5
        redirect_to new_hunt_questionset_path(@hunt), notice: 'Question was successfully created.'
      else
        redirect_to hunt_path(@hunt), notice: 'Question was successfully created.'
      end
    else
        redirect_to hunt_path(@hunt), notice: 'Question was not created.'
    end

  end


  def destroy
    @questionset = Questionset.find(params[:id]).destroy
    redirect_to @questionset, notice: 'Questionset was successfully deleted'
  end


  def edit
      binding.pry
     @questionset = Questionset.find(params[:id])

  end

  def update

    @hunt = Hunt.find(params[:question_id])
    @questionset = Questionset.update(quiz_params)
    #@questionset = @hunt.questionset.update(answer_params)
    redirect_to @hunt, notice: 'Questionset was successfully updated'
  end



  #private

  # Never trust parameters from the scary internet, only allow the white list through.
  def quiz_params
    params.require(:questionset).permit(:hunt_id, :question, :question_no, :address, :latitude, :longitude)
  end

  def user_signed_in?
    redirect_to root_path unless current_user
  end
end
