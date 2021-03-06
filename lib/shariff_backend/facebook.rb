require 'httpclient'
require 'json'

module ShariffBackend
  # Retrieves Facebook Share Count via Graph API
  module Facebook
    def self.count(url)
      query_url = "http://graph.facebook.com/?id=#{url}"
      encoded = URI.escape(query_url)
      response = HTTPClient.new.get(encoded)
      response.ok? ? parse(response) : ''
    end

    def self.parse(response)
      json = JSON.parse(response.body)
      count = json['share']['share_count']
      count ? count : 0
    rescue
      ''
    end
  end
end
