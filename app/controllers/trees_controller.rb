
class TreesController < ApplicationController
  before_action :authenticate_user!

  # GET /users
  def index
   binding.pry
   # @questionset =
   # @itinerary_array = @questionset.uptoquestion(maxquestion_no.question_no)

  end


  def show


  end





  private

  # Never trust parameters from the scary internet, only allow the white list through.
  #def question_params
  #  params.require(:user).permit(:title, :description, :url, :submitter)
  #end
end
