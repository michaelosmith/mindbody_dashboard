class GetTokenController < ApplicationController

  def index

  end

  def new
    @token = current_user.token
  end

  def create
    token = get_auth_token(params[:email], params[:password], params[:site_id])
    current_user.token = token
    current_user.token_last_used_at = Time.zone.now

    if current_user.save
      redirect_to root_path
    end
  end

  private

  def parse(response_body)
    JSON.parse(response_body, symbolize_names: true)
  end

  def get_auth_token(email, password, site_id)
    api_key = Rails.application.credentials.mindbody[:api_key]
    staff_username = email
    staff_password = password
    headers  = { 
      'Content-Type': 'application/json',
      'Api-Key': api_key,
      'SiteId': site_id
    }
    
    request = Typhoeus::Request.new(
      "https://api.mindbodyonline.com/public/v6/usertoken/issue",
      method: :post,
      headers: headers,
      body: JSON.dump({"Username": "#{staff_username}", "Password": "#{staff_password}"})
    ).run
    parse(request.response_body)[:AccessToken]
  end
end
