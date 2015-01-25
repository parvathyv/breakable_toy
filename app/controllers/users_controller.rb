
class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @hunts_owned = @user.hunts
    @hunts_completed = Huntsplayeduser.find_hunts(@user.id)
    @other_users = User.where("id != ?", current_user.id)
    @other_user_hunts = @other_users.map do|user|
      Huntsplayeduser.find_hunts(user.id)
    end
    @other_user_hunts.reject! { |c| c.empty? }

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      redirect_to root_path, notice: 'User was successfully updated.'
    else
      flash[:notice] = 'User was not updated.'
      render action: 'edit'
    end
  end

 private
 def user_params
    params.require(:user).permit(:profile_photo, :name, :email, :password)
 end

end
