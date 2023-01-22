def site_id
  -99
end

def mindbody_service
  @service = Mindbody::Service.new(Rails.application.credentials.mindbody[:api_key],
                                   site_id,
                                   current_user.slug)
end