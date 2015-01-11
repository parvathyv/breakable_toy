
class HuntsplayedusersController < ApplicationController
  before_action :authenticate_user!, :only => [:edit, :update, :destroy]
  # GET /huntsplayedusers
  def index
   @huntsplayedusers = Huntsplayeduser.all

  end



  # GET /huntsplayedusers/new
  def new

    @huntsplayeduser = Huntsplayeduser.new

  end

  # POST /huntsplayedusers
  def create

    @hunt = Hunt.find(params[:hunt_id])
    @questionset = Questionset.find(params[:questionset_id])
    @msg = @questionset.check_answer(params[:address][:address])
        if !@msg.include?'Sorry'



          @flm = 1
        end
    #binding.pry

    #redirect_to hunt_questionset_path(@hunt, @questionset)

    #@huntsplayeduser = @huntsplayeduser.build(hunt_params)

    #@huntsplayeduser.user = current_user

  #  if @huntsplayeduser.save
   #   redirect_to hunt_questionset_path(@hunt, @questionset), notice: 'Huntsplayeduser was successfully created.'
      #redirect_to new_hunt_quiz_path(@huntsplayeduser), notice: 'Huntsplayeduser was successfully created.'
   # else

      redirect_to hunt_questionset_path(@hunt, @questionset), notice: 'Huntsplayeduser was not created.'
   # end
  end





  #private

  # Never trust parameters from the scary internet, only allow the white list through.
  def huntsplayed_params
    params.require(:huntsplayeduser).permit(:hunt_id,:user_id,:question_no,:user_session_id)
  end


end
