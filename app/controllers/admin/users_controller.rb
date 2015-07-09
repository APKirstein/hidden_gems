module Admin
  class UsersController < ApplicationController
    before_filter :authorize_admin!
    
    def index
      @users = User.where(role: 'user').page(params[:page])
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      flash[:notice] = "Successfully deleted #{@user.username}!"
      redirect_to admin_users_path
    end
  end
end
