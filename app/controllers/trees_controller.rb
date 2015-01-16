
class TreesController < ApplicationController
  before_action :authenticate_user!

  # GET /users
  def index
   @my_hash1 = Location.get_tree(params[:format])
    respond_to do |format|
      format.html { render :index}
      format.json { render json: @my_hash1 }
    end

  end

  # GET /users/1
  def show


  end





  private

  # Never trust parameters from the scary internet, only allow the white list through.
  #def question_params
  #  params.require(:user).permit(:title, :description, :url, :submitter)
  #end
end
