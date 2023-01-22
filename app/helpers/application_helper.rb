module ApplicationHelper

  def flash_classes(flash_type)
    flash_base = "px-2 py-4 mx-auto font-sans font-medium text-center text-white"
    {
      notice: "green",
      alert: "yellow",
      error:  "red",
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_message(flash_type, flash_message)
    case flash_type
    when "notice"
      "<div class='p-4 mb-4 text-sm text-green-700 bg-green-100 rounded-lg dark:bg-green-200 dark:text-green-800' role='alert'>
      <span class='font-medium'>#{flash_message}</span>
    </div>"
    when "alert"
      "<div class='p-4 mb-4 text-sm text-yellow-700 bg-yellow-100 rounded-lg dark:bg-yellow-200 dark:text-yellow-800' role='alert'>
      <span class='font-medium'>#{flash_message}</span>
    </div>"
    when "error"
      "<div class='p-4 mb-4 text-sm text-red-700 bg-red-100 rounded-lg dark:bg-red-200 dark:text-red-800' role='alert'>
      <span class='font-medium'>#{flash_message}</span>
    </div>"
    else
      "<div class='p-4 mb-4 text-sm text-blue-700 bg-blue-100 rounded-lg dark:bg-blue-200 dark:text-blue-800' role='alert'>
      <span class='font-medium'>#{flash_message}</span>
    </div>"
    end
  end
  
  def valide_user_token?
    token_expiry = 7.days.ago
    token_last_used_at = current_user.token_last_used_at || 8.days.ago

    if current_user.token && token_last_used_at.after?(token_expiry)
      true
    else
      false
    end
  end

  def stripe_express_dashboard_link
    link = Stripe::Account.create_login_link(current_user.stripe_account_id)
    link.url
  end
end
