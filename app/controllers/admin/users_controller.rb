module Admin
  class UsersController < ApplicationController
    before_filter :admin_authorize!
    def index
      @users = User.all
    end

    def destroy
      @user = User.find(params[:id])
      @user = User.find(params[:id]).destroy
      if @user.destroy
        redirect_to admin_users_path, :notice => "User successfully deleted"
      else
        render :edit, :notice => "User did not delete"
      end
    end

    def edit
      @user = User.find(params[:id])
    end

  end
end