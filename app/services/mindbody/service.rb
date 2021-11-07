module Mindbody
  class Service < Base
    def initialize(api_key, site_id, app_name)
      @base_url = 'https://api.mindbodyonline.com/public/v6'
      @headers  = { 
        'Api-Key': api_key
        'SiteId': site_id
        'User-Agent': app_name
      }
      @request_pool = Typhoeus::Hydra.hydra
    end

    def get_all_clients
      page_size = 200
      offset = 0
      all_clients_total = get_total_number_of_clients
      loops = calculate_request_loops(all_clients_total)

      requests = loops.times.map do
        request = Typhoeus::Request.new(
          "#{base_url}/client/clients",
          params: {
            limit: page_size,
            offset: offset
          },
          headers: headers
        )

        offset += page_size
        
        request_pool.queue(request)
        request
      end

      request_pool.run
      
      requests.reduce([]) do |clients, request|
        parsed = parse(request.response.body)[:Clients]
        parsed.each do |client|
          clients << client unless client.empty?
        end
        clients
      end
    end

    def get_single_client(client_id)
      request = Typhoeus::Request.new(
        "#{base_url}/client/clients",
        params: { ClientIds: client_id },
        headers: headers
      ).run
      parse(request.response_body)[:Clients]
    end


    private

    attr_reader :base_url, :headers, :request_pool

    def rate_limited?(response)
      response.code == 429
    end

    def get_total_number_of_clients
      request = Typhoeus::Request.new(
        "#{base_url}/client/clients",
        params: { 
          limit: 1,
          offset: 0
        },
        headers: headers
      ).run
      parse(request.response_body)[:PaginationResponse][:TotalResults]
    end

    def calculate_request_loops(total_clients)
      (total_clients / 200.00).ceil
    end
  end
end