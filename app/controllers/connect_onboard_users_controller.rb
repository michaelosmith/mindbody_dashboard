class ConnectOnboardUsersController < ApplicationController
  
  def create
    
    account = Stripe::Account.create(
      email: current_user.email,
      type: 'express'
    )
    
    current_user.stripe_account_id = account.id

    if current_user.save
      account_link = Stripe::AccountLink.create(
        account: account.id,
        refresh_url: root_url + '/connect_onboard_user/reauth',
        return_url: root_url,
        type: 'account_onboarding'
      )

      redirect_to account_link.url, allow_other_hosts: :true
      flash[:notice] = "Success, you connected Stripe ✅"
    else
      flash[:notice] = "Something went wrong!!"
    end
  end
end