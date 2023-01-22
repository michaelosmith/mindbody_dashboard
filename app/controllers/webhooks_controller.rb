class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = Rails.application.credentials[:stripe][:webhook_secret]
    event = nil

    begin
      # debugger
      event = Stripe::Webhook.construct_event(
          payload, sig_header, endpoint_secret
        )
    rescue JSON::ParserError => e
        # Invalid payload
        status 400
        return
    rescue Stripe::SignatureVerificationError => e
        # Invalid signature
        status 400
        return
    end

    # Handle the event
    case event.type
    when 'payment_intent.succeeded'
      # debugger
        payment_intent = event.data.object
    # ... handle other event types
    when 'checkout.session.completed'
      
      member = Member.find(event.data.object.client_reference_id.to_i)
      debugger
      mindbody = connect_to_mindbody(member.user.slug)
      mindbody_member = mindbody.add_client(member.first_name, member.last_name, member.email, "01/01/2000")
      

    when 'account.updated'
      # debugger
      if event.data.object.details_submitted
        user = User.find_by(stripe_account_id: event.data.object.id)
        user.stripe_account_active = true
        user.save
      end
    else
        puts "Unhandled event type: #{event.type}"
    end

    render json: {message: 'success'}
  end


private

  def connect_to_mindbody(slug)
    Mindbody::Service.new(Rails.application.credentials.mindbody[:api_key],
                          site_id,
                          slug)
  end
end
