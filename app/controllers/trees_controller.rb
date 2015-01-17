
class TreesController < ApplicationController
  before_action :authenticate_user!

  def show

    @hunt = Hunt.find(params[:id])

    @itinerary_array = @hunt.questionsets.first.uptoquestion(5)
    @places_array = @hunt.questionsets.map{|ques| ques.address}
    #binding.pry



  end





  private

  # Never trust parameters from the scary internet, only allow the white list through.
  #def question_params
  #  params.require(:user).permit(:title, :description, :url, :submitter)
  #end
end
