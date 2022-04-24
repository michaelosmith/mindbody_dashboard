class HomeController < ApplicationController
  before_action :authenticate_user!
  append_before_action :check_token_set

  def index
    
  end

  private

  def user_token_used_in_last_seven_days?
    token_expiry = 7.days.ago
    token_last_used_at = current_user.token_last_used_at || 8.days.ago

    if current_user.token && token_last_used_at.after?(token_expiry)
      true
    else
      false
    end
  end

  def check_token_set
    if user_signed_in?
      user = User.find(current_user.id)
    else
      return
    end

    if user_token_used_in_last_seven_days?
      # redirect_to app_root_path
      p "Good to go"
    else
      # redirect_to new_token_path
      p "Need token"
    end
  end
end