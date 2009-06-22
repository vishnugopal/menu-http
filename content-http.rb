
# Content HTTP

# Run using ruby -rubygems content-http.rb -p 3301

require 'sinatra'
require 'json'

$cache = {}
$curr_path = File.dirname(__FILE__)

class MenuNotFoundError < StandardError; end

def load_menu(menu_name)
 $cache[menu_name] ||= JSON.load(File.open("#{$curr_path}/menus/#{menu_name}.json"))
end

get '/response/:menu_name/*' do
  content_type 'application/javascript', :charset => 'utf-8'

  load_menu(params[:menu_name])
  $cache[params[:menu_name]][params[:splat][0]].to_json
end

get '/key/:menu_name/*/:choice' do
  content_type 'application/javascript', :charset => 'utf-8'

  load_menu(params[:menu_name])
  [$cache[params[:menu_name]][params[:splat][0]][1][params[:choice].to_i][0]].to_json
end

not_found do
  content_type 'application/javascript', :charset => 'utf-8'
  {"error" => "MalformedRequest"}.to_json
end

error do
  content_type 'application/javascript', :charset => 'utf-8'
  {"error" => env['sinatra.error'].name}.to_json
end

error MenuNotFoundError do
  content_type 'application/javascript', :charset => 'utf-8'
  {"error" => "MenuNotFoundError"}.to_json
end

error NoMethodError do
  content_type 'application/javascript', :charset => 'utf-8'
  {"error" => "MenuKeyNotFound"}.to_json
end



