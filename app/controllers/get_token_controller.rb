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
    api_key = ''
    staff_username = email
    staff_password = password

    require 'uri'
    require 'net/http'

    url = URI("https://api.mindbodyonline.com/public/v6/usertoken/issue")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = 'application/json'
    request["Api-Key"] = api_key
    request["SiteId"] =  site_id
    request.body = "{\r\n\t\"Username\": \"#{staff_username}\",\r\n\t\"Password\": \"#{staff_password}\"\r\n}"

    response = http.request(request)
    token_json = parse(response.read_body)
    token_json[:AccessToken]
  end
end
