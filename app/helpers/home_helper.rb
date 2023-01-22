module HomeHelper

  def welcome_message
    if user_signed_in?
    content_tag(:p, "Welcome! Have a look around")
    else
    content_tag(:p, "Welcome! Please sign in")
    end
  end

  def required_fields
    mindbody_service.get_required_client_fields
  end

  def add_client
    mindbody_service.add_client
  end

  def get_services
    mindbody_service.get_services
  end

  def client_cart
    mindbody_service.purchase_cart(100011914,1357)
  end

  def get_custom_payment_methods
    mindbody_service.get_custom_payment_methods
  end


private

  # def service
  #   @service = Mindbody::Service.new(Rails.application.credentials.mindbody[:api_key],
  #                                    site_id,
  #                                    current_user.token)
  # end
end