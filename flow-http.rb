
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
# $state[state_id] just points to a URI, like "pizza/order"
$state ||= {}

def get_response(menu_name, uri)
  url = "http://#{$config[:content_http_host]}:#{$config[:content_http_port]}/response/#{menu_name}/#{uri}"
  puts "Calling url: #{url}"
  open(url).read
end

def get_key(menu_name, uri, choice)
  url = "http://#{$config[:content_http_host]}:#{$config[:content_http_port]}/key/#{menu_name}/#{uri}/#{choice}"
  puts "Calling url: #{url}"
  JSON.load(open(url).read)[0]
end

get '/:menu_name/:state_id/:choice' do
  content_type 'application/javascript', :charset => 'utf-8'
  
  puts "State is #{$state.inspect.to_s}"
  
  if params[:choice] == "index"
    $state[params[:state_id]] = "index"
  else 
    $state[params[:state_id]] = get_key(params[:menu_name], $state[params[:state_id]], params[:choice])
  end
  
  response = get_response(params[:menu_name], $state[params[:state_id]])
  
end







