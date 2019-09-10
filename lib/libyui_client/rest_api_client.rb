# frozen_string_literal: true

require 'json'
require 'net/http'
require 'uri'
require 'timeout'

class WidgetNotFound < RuntimeError
end

# default timeout for actions
DEFAULT_TIMEOUT_ACTIONS = 15

def timed_retry(seconds, &block)
  timeout = seconds.to_i
  timeout = DEFAULT_TIMEOUT_ACTIONS if timeout == 0

  Timeout.timeout(timeout) do
    begin
      loop do
        break if block.call

        puts 'Retrying...' if ENV['DEBUG']
        sleep(1)
      end
    rescue WidgetNotFound
      sleep(1)
      retry
    end
  end
end

def send_request(method, path, params = {})
  uri = URI("http://#{@app_host}:#{@app_port}")
  uri.path = path
  uri.query = URI.encode_www_form(params)

  puts "Query: #{uri}" if ENV['DEBUG']

  if method == :get
    res = Net::HTTP.get_response(uri)
  elsif method == :post
    # a trick how to add query parameters to a POST request,
    # the usuall Net::HTTP.post(uri, data) does not allow using a query
    req = Net::HTTP::Post.new("#{uri.path}?#{uri.query}")
    http = Net::HTTP.new(uri.host, uri.port)
    res = http.request(req)
  else
    raise "Unknown HTTP method: #{method.inspect}"
  end

  puts "Response (#{res.code}:#{res.message}): #{res.body}" if ENV['DEBUG']
  if res.is_a?(Net::HTTPSuccess)
    res.body.empty? ? nil : JSON.parse(res.body)
  elsif res.is_a?(Net::HTTPNotFound)
    raise WidgetNotFound, 'Widget not found'
  else
    raise "Error code: #{res.code} #{res.message}"
  end
end

def send_action(action: nil, type: nil, label: nil, id: nil, value: nil)
  params = {}
  params[:action] = action if action
  params[:id] = id if id
  params[:label] = label if label
  params[:type] = type if type
  params[:value] = value if value

  send_request(:post, '/widgets', params)
end
