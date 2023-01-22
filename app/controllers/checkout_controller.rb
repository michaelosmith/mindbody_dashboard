class CheckoutController < ApplicationController
  skip_before_action :authenticate_user!
  
  def create
    # debugger
    member = Member.find_by(email: params[:member][:email])
    trial = Trial.find(params[:member][:trial_id])

    session = Stripe::Checkout::Session.create({
      success_url: root_url + '/trial_success',
      cancel_url: root_url,
      client_reference_id: member.id.to_s,
      line_items: [
        {
          name: trial.name,
          amount: trial.price,
          currency: "aud",
          quantity: 1
        }
      ],
      mode: 'payment',
      customer_email: member.email,
      payment_intent_data: {
        application_fee_amount: 123,
        transfer_data: {
          destination: params[:member][:stripe_connect_account_id],
        },
      },
    })

    redirect_to session.url, allow_other_hosts: :true
  end
end