require 'test/unit'
require 'open-uri'
require 'json'

def flow_response_for_choices(choices)
  config = {}
  config[:flow_http_host] = "localhost"
  config[:flow_http_port] = "3302"
  menu_name = "test" 
  session_id = (rand * 1000).to_i
  
  response = ""
  choices.each do |choice|
    url = "http://#{config[:flow_http_host]}:#{config[:flow_http_port]}/#{menu_name}/#{session_id}/#{choice}"
    response = JSON.load(open(url).read)
  end
  response
end

