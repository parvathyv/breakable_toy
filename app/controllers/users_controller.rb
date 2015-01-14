
class UsersController < ApplicationController
  before_action :authenticate_user!

  # GET /users
  def index
    @users = User.all
    @user = current_user
    @hunts_owned = @user.hunts
    binding.pry
   # @hunts_completed = Huntsplayeduser.where("user_id=?",current_user.id).group(:hunt_id).count(:id)
   @hunts_completed = Huntsplayeduser.find_hunts(@user.id)

  end

  # GET /users/1
  def show
   @user = User.find(params[:id])
  end





  private

  # Never trust parameters from the scary internet, only allow the white list through.
  #def question_params
  #  params.require(:user).permit(:title, :description, :url, :submitter)
  #end
end
