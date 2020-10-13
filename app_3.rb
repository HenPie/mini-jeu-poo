require 'bundler'
Bundler.require 

require_relative 'lib/game'
require_relative 'lib/player'

puts "-------------------------------------------------"
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-------------------------------------------------"

puts "Quel est ton nom guerrier ?"
my_game = gets.chomp
my_game = Game.new(my_game)

while my_game.is_still_ongoing? == true 
  my_game.show_players
  my_game.new_players_in_sight
  my_game.menu
  choice = gets.chomp
  my_game.menu_choice(choice)
  my_game.enemies_attack
end

my_game.end