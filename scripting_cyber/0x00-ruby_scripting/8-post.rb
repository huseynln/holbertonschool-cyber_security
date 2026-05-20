require 'net/http'
require 'uri'
require 'json'

def post_request(url, body_params = {})
  uri = URI.parse(url)

  request = Net::HTTP::Post.new(uri)
  request.content_type = 'application/json'
  request.body = body_params.to_json unless body_params.empty?

  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
    http.request(request)
  end

  puts "Response status: #{response.code} #{response.message}"
  puts "Response body:"

  parsed = JSON.parse(response.body)
  if parsed.empty?
    puts "{}"
  else
    puts JSON.pretty_generate(parsed)
  end
end
