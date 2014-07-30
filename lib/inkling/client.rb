require "faraday"
require "faraday_middleware"

module Inkling
  class Client
    def initialize(opts = {})
      raise Inkling::CredentialError.new unless opts[:username] && opts[:password]
      raise Inkling::SubdomainError.new unless opts[:subdomain]

      @username = opts[:username]
      @password = opts[:password]
      @subdomain = opts[:subdomain]
    end

    def api_endpoint
      if Inkling.environment == "production"
        "https://#{@subdomain}.inklingmarkets.com/"
      else
        "http://#{@subdomain}.inklinghq.com/"
      end
    end

    # for easy test stubbing
    def adapter_opts
      [Faraday.default_adapter]
    end

    def conn
      @conn ||= build_conn
    end

    def build_conn
      connection = Faraday.new(api_endpoint) do |co|
        co.request :url_encoded
        #co.response :xml
        #co.response :logger
        co.adapter *adapter_opts
      end
      
      connection.headers = {'Accept' => 'application/xml'}
      connection.basic_auth(@username, @password)

      connection
    end

    def make_request(type, path, params = nil)
      url = "#{api_endpoint}#{path}"
      response = case type
      when :get
        conn.get(url, params)
      when :post
        conn.post(url, params)
      end
      
      if response.success?
        response.body
      else
        false
      end
    rescue Faraday::Error::ParsingError => e
      binding.pry
      false
    end
  end
end