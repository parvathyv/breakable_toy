require 'json'
class QuestionsetsController < ApplicationController
  before_action :authenticate_user!, :only => [:show, :edit, :update, :destroy]
  # GET /quizzes
  def index
    @my_hash = {"name"=>"Cities",
      "children"=>[{"name"=>"Boston",
      "children"=>[{"name"=>"Freedom Trail",
      "children"=>[{"name"=>"Faneiul Hall", "size"=>3938},
      {"name"=>"Boston Commons", "size"=>3812},
      {"name"=>"King's Chapel", "size"=>6714},
      {"name"=>"Bunker Hill", "size"=>743}]},
      {"name"=>"Eat Boston", "children"=>[{"name"=>"Wagamama", "size"=>3534}, {"name"=>"Dumpling King", "size"=>5731}]},
      {"name"=>"Beantown Sports", "children"=>[{"name"=>"Fenway", "size"=>7074}]}]}]}


    #binding.pry


  end

  # GET /quizzes/1
  def show
    @hunt = Hunt.find(params[:hunt_id])
    @questionset = Questionset.find(params[:id])
    #@clues = @questionset.get_clue
    #@firstone = @clues[0].to_s
    #binding.pry


    @flm = 0
    @msg = "Let's go..."

    @itinerary = @questionset.upto

    if params[:address] != nil
      @msg = @questionset.check_answer(params[:address][:address])
        if !@msg.include?'Sorry'


         # binding.pry
          @flm = 1
        end
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


  def edit

     @questionset = Questionset.find(params[:id])

  end

  def update

    @hunt = Hunt.find(params[:hunt_id])
    @questionset = Questionset.find(params[:id])
    @questionset.update(quiz_params)

    redirect_to @hunt, notice: 'Questionset was successfully updated'

  end



  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def quiz_params
    params.require(:questionset).permit(:hunt_id, :question, :question_no, :address, :latitude, :longitude)
  end





end
