class QuestionsetsController < ApplicationController
  before_action :authenticate_user!, :only => [:show, :edit, :update, :destroy]
  # GET /quizzes
  def index
=begin
    @locations = Location.find(1).address
    @hunts = Location.find(1).hunts
    #.map{|hunt| hunt.name}
    #@questionsets = ['F1','F2','F3','F4']
    @my_hash1 = {}
    hash = {}
    hash1= {}
    arr = []
    arr1 = []
    arr2=[]


    1.times do |n|

      @my_hash1["name"] = @locations[n]


    # @hunts.size.times do |n1|
      @hunts.each do|hunt|
        hash = {}
        arr = []
        hash["name"] = hunt.name
        # @hunts[n1]
        arr1 << hash


        #@questionsets.size.times do |n2|
        hunt.questionsets.each do|ques|
          hash1={}
          #arr = []
          hash1["name"] = ques.address
          #@questionsets[n2]
          hash1["size"] = 1000 + rand(120)
          arr << hash1

         end
         hash["children"] = arr
         @my_hash1["children"] = arr1

        end
          # @my_hash1["children"] = hash

         # binding.pry

   binding.pry


    end


=end
    @my_hash = {"name"=>"Cities",

      "children"=>[{"name"=>"Boston",
      "children"=>[{"name"=>"Freedom Trail",
      "children"=>[{"name"=>"Faneiul Hall", "size"=>3938},
      {"name"=>"Boston Commons", "size"=>3812},
      {"name"=>"King's Chapel", "size"=>6714},
      {"name"=>"Bunker Hill", "size"=>743}]},
      {"name"=>"Eat Boston", "children"=>[{"name"=>"Wagamama", "size"=>3534}, {"name"=>"Dumpling King", "size"=>5731}]},
      {"name"=>"Beantown Sports", "children"=>[{"name"=>"Fenway", "size"=>7074}]}]}]}



    respond_to do |format|
      format.html { render :index }
      format.json { render json: @my_hash }
    end


  end

  # GET /quizzes/1
  def show
    arr = []
    @hunt = Hunt.find(params[:hunt_id])

    @questionset = Questionset.find(params[:id])
    @itinerary =['You have to play']
    @itinerary_array = [@hunt.location.latitude, @hunt.location.longitude]
    @huntsplayed = Huntsplayeduser.if_exists?(params[:hunt_id], session.id, current_user.id)

    if @huntsplayed.empty? == false && @huntsplayed.count < 5
      @itinerary = @huntsplayed.each{|hunt| hunt}

      @itinerary_array = @itinerary.each {|iter| arr < [iter.latitude, iter.longitude]}

      maxquestion_no = Huntsplayeduser.hunt_check(@huntsplayed.last.question_no, params[:hunt_id], session.id)

      if maxquestion_no.question_no < 6

        if @questionset.question_no == maxquestion_no.question_no
          @questionset = @questionset.next
          @huntsplayed = Huntsplayeduser.new

        else
          if @questionset.question_no - maxquestion_no.question_no > 1 || maxquestion_no.question_no > @questionset.question_no

            @questionset = Questionset.where("question_no=? and hunt_id=?", maxquestion_no.question_no + 1, params[:hunt_id]).first

            @huntsplayed = Huntsplayeduser.new
            if @questionset.question_no - maxquestion_no.question_no > 1
              @msg = "Please play in order"
            else
              @msg = "Welcome back"
            end

          else

               if @questionset.question_no - maxquestion_no.question_no == 1

                @huntsplayed = Huntsplayeduser.new

               end


          end
        end

      end

   else
    if @huntsplayed.count == 5


      redirect_to root_path, notice: 'You already played this hunt this session, sign out if you want to repeat'
    else
      @huntsplayed = Huntsplayeduser.new


      @msg = "Let's go..."
    end



   end
   @clues = @questionset.get_clue

  end

  # GET /quizzes/ne
  def new

    @questionset = Questionset.new
    @hunt = Hunt.find(params[:hunt_id])

  end

  # POST /quizzes
  def create
    @hunt = Hunt.find(params[:hunt_id])

    @questionset = @hunt.questionsets.build(questionset_params)

    @last_quiz = Questionset.where("hunt_id=?", @hunt.id)

    if @last_quiz == nil || @last_quiz.empty?
      @questionset.question_no = 1
    else
      @questionset.question_no = @last_quiz.last.question_no + 1
    end

    if @questionset.save

      if @questionset.question_no < 6
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
    @questionset.update(questionset_params)

    redirect_to @hunt, notice: 'Questionset was successfully updated'

  end




  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def questionset_params
    params.require(:questionset).permit(:hunt_id, :question, :question_no, :address, :latitude, :longitude)
  end





end
