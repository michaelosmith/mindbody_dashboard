module ApplicationHelper

  def valide_user_token?
    token_expiry = 7.days.ago
    token_last_used_at = current_user.token_last_used_at || 8.days.ago

    if current_user.token && token_last_used_at.after?(token_expiry)
      true
    else
      false
    end
  end
end
