
# Just a simple request-response menu tester
# Simulates how a real thing will work.
# Assumes flow-http runs at localhost:3302, content-http runs at localhost:3301


require 'open-uri'
require 'json'

$config = {}
$config[:flow_http_host] = "localhost"
$config[:flow_http_port] = "3302"


puts "Menu browser"
puts "Enter name of menu to load, default 'sample1'"
$menu_name = gets.chomp
$menu_name = "sample1" if $menu_name == "" 

# We use only two variables, session_id and choice to find the output
$session_id = (rand * 1000).to_i
$choice = "index" #initial choice is "index" to mark start

def flow_response
  url = "http://#{$config[:flow_http_host]}:#{$config[:flow_http_port]}/#{$menu_name}/#{$session_id}/#{$choice}"
  puts "Calling url: #{url}"
  JSON.load(open(url).read)
end


def menu(menu)
  menu.each_with_index do |item, index|
    puts "#{index + 1}: #{item[1]}"
  end
  gets.chomp.to_i - 1
end


while response = flow_response
  if response[0] == "menu"
    $choice = menu(response[1])
  else
    puts "#{response[0]}: #{response[1]}"
    exit
  end
end