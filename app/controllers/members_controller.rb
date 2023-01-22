class MembersController < ApplicationController
  before_action :set_user
  skip_before_action :authenticate_user!, except: [:show, :index]

  def index
    
  end

  def new
    @member = @user.members.new
    @trials = @user.trials.all
  end

  def create
    @member = @user.members.new(member_params)
    if @member.save
      p @member.id
      if user_signed_in?
        p "*** SIGNED IN ***"
        redirect_post checkout_create_path(params: request.parameters), options: {authenticity_token: :auto}
      else
        redirect_post checkout_create_path(params: request.parameters)
      end
    else
      render :new
    end
  end


private

  def member_params
    params.require(:member).permit(:first_name, :last_name, :email)
  end

  def set_user
    @user = User.find_by(slug: params[:user_slug])
  end
end
