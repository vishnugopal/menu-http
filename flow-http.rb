
# Flow HTTP
# Assumes content-http.rb is running at localhost:3301

# Run using ruby -rubygems flow-http.rb -p 3302

# This is also a sample of how a flow browser should be implemented on top of content-http

require 'open-uri'
require 'json'
require 'sinatra'


$config = {}
$config[:content_http_host] = "localhost"
$config[:content_http_port] = "3301"

# Use some other sort of caching, like Memcache, just implement [], []= for the new State Cache.
# We use a hash only for demo purposes.
# $state[client_id] just points to a URI, like "pizza/order"
$state ||= {}

def get_response(menu_name, uri)
  url = "http://#{$config[:content_http_host]}:#{$config[:content_http_port]}/response/#{menu_name}/#{uri}"
  puts "Calling url: #{url}"
  JSON.load(open(url).read)
end

def get_key(menu_name, uri, choice)
  url = "http://#{$config[:content_http_host]}:#{$config[:content_http_port]}/key/#{menu_name}/#{uri}/#{choice}"
  puts "Calling url: #{url}"
  JSON.load(open(url).read)[0]
end

def process_response(menu_name, uri)
  response = get_response(menu_name, uri)
  puts "Response is: #{response.inspect.to_s}"
  response = case response[0]
  # redirect
  when "redirect"
    puts "Redirect found!"
    $state[params[:client_id]] = response[1]
    get_response(menu_name, response[1])
  when "url"
    #TODO: validate that this is actually a http(s):// url
    puts "URL found!"
    [:message, open(response[1]).read]
  else
    response
  end
  response.to_json
end

get '/:menu_name/:client_id/:input' do
  content_type 'application/javascript', :charset => 'utf-8'
  
  puts "State is #{$state.inspect.to_s}"
  
  if params[:input] == "index"
    $state[params[:client_id]] = "index"
  elsif params[:input].to_i.to_s == params[:input] # i.e. it's an Integer
    $state[params[:client_id]] = get_key(params[:menu_name], $state[params[:client_id]], params[:input])
  end
  
  process_response(params[:menu_name], $state[params[:client_id]])
end







