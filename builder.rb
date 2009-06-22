
require 'json'

# Generates a serialized JSON menu by asking you questions
# It doesn't validate the JSON output in any way.

$menu = {}

def create_menu
  loop do
    puts "Menu URI?"
    menu_key = gets.chomp
    puts "Enter your next type (default 'menu')"
    menu_type = gets.chomp
    menu_type = "menu" if menu_type == ''
    if menu_type == "menu"
      loop do 
        puts "Next menu choice name?"
        menu_choice = gets.chomp
        puts "Next menu uri target?"
        menu_uri = gets.chomp
        $menu[menu_key] ||= [] 
        $menu[menu_key][0] ||= "menu"
        $menu[menu_key][1] ||= []
        $menu[menu_key][1] << [menu_uri, menu_choice]
        puts "Continue menu choices? (y/n)"
        break if gets.chomp.downcase == 'n'
      end
    else
      puts "Menu value?"
      menu_value = gets.chomp
      $menu[menu_key] ||= []
      $menu[menu_key][0] = menu_type
      $menu[menu_key][1] = menu_value
    end
    puts "Continue menu creation? (y/n)"
    break if gets.chomp.downcase == "n"
  end
end
      

create_menu

puts "Created Menu:"

puts JSON.pretty_generate($menu)

