class UsersController < ApplicationController

  def show
    @user = User.find_by slug: params[:slug]
    @members = @user.members
  end
end