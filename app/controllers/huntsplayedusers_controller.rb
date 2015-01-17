
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
    @flm = 0
    @is_order = false
    # check if hunt exists in table


    # if maxqno is 1 less than current qno, add the record
    # if not, tell the user not to cheat
    @questionset = Questionset.find(params[:questionset_id])

    @hunt = @questionset.hunt
    user_session_id = session.id
    @huntcheck = Huntsplayeduser.if_exists?(@hunt.id, user_session_id, current_user.id)


    if @huntcheck.empty? == false
      maxquestion_no = Huntsplayeduser.hunt_check(@questionset.question_no,@hunt.id, session.id)

      if maxquestion_no.question_no == @questionset.question_no - 1

         @msg = @questionset.check_answer(params[:huntsplayeduser][:address])
          if !@msg.include?'Sorry'
            @flm = 1

            @is_order = true

          end
      end
    end


    #redirect_to hunt_questionset_path(@hunt, @questionset)
    if @is_order == true || @questionset.question_no == 1
     # @huntsplayeduser = Huntsplayeduser.new
      params[:huntsplayeduser][:hunt_id] = @hunt.id
      params[:huntsplayeduser][:user_id] = current_user.id
      params[:huntsplayeduser][:user_session_id] = session.id
      params[:huntsplayeduser][:question_no]= @questionset.question_no

      @huntsplayeduser = Huntsplayeduser.create(huntsplayeduser_params)

      #@huntsplayeduser.user = current_user
      @flm = 1
      if @huntsplayeduser.save
        if @huntsplayeduser.question_no < 5
          @prize = 0
          if @questionset.next
            redirect_to hunt_questionset_path(@hunt, @questionset.next), notice: 'Correct, move on!'
          else
            redirect_to root_path, notice: 'Hunt incomplete'
          end
          else
          @prize = 1

          redirect_to hunt_questionset_path(@hunt, @questionset), notice: 'You are done ! Congrats'
        end
      else

        redirect_to hunt_questionset_path(@hunt, @questionset), notice: 'Please play in order'
      end

    else

        redirect_to hunt_questionset_path(@hunt, @hunt.questionsets.first), notice: @msg
    end




  end





  #private

  # Never trust parameters from the scary internet, only allow the white list through.
  def huntsplayeduser_params

   params.require(:huntsplayeduser).permit(:hunt_id, :user_id, :address, :question_no,:user_session_id)
  end


end
