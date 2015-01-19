
class TreesController < ApplicationController
  before_action :authenticate_user!

  def show

    @hunt = Hunt.find(params[:id])

    @itinerary_array = @hunt.questionsets.first.uptoquestion(5)
    @places_array = @hunt.questionsets.order(:question_no)

    @content_array = @hunt.questionsets.map{|question| question.description.to_s}


  end


end
