
class TreesController < ApplicationController
  before_action :authenticate_user!

  def show
    @content_array = []
    @hunt = Hunt.find(params[:id])
    @itinerary_array = @hunt.questionsets.first.uptoquestion(5)
    @places_array = @hunt.questionsets.order(:question_no)
    @hunt.questionsets.map do |question|
      if question.description != nil
       @content_array << "<img src="+"#{question.hunt_photo}><div>"+ question.description.to_s+"</div>"
      end
    end

  end


end
