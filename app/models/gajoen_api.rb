require 'net/https'
require 'uri'
require 'securerandom'

class GajoenApi
  def self.create_tickets(brand_id, item_id)
    request_code = SecureRandom.urlsafe_base64(30)
    query={
      :item_id => item_id,
      :request_code => request_code
    }
    url = ENV['GAJOEN_DOMAIN']+ "/brands/#{brand_id}/tickets/"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    req = Net::HTTP::Post.new(uri.request_uri)
    req['Authorization'] = ENV['GAJOEN_HEADER']
    req['X-Giftee'] = 1
    req.set_form_data(query)
    res = http.request(req)
    p res
    case res
    when Net::HTTPSuccess
      return JSON.parse(res.body)
    else
      raise
    end
  end
end
