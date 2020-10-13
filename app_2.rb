require 'bundler'
Bundler.require 

require_relative 'lib/game'
require_relative 'lib/player'

puts "-------------------------------------------------"
puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-------------------------------------------------"

puts "Quel est ton nom guerrier ?"
user = gets.chomp
user = HumanPlayer.new(user)

player1 = Player.new("Josiane")
player2 = Player.new("José")
enemies = [player1, player2]

while user.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0)
  puts"----------------------------\n"
  puts "Voici votre état de santé :"
  user.show_state

  puts"----------------------------\n"
  puts "Quelle action veux-tu effectuer ?"
  puts "a - chercher une meilleure arme"
  puts "s - chercher à se soigner"
  puts "Attquer un joueur en vue :"
  puts "0 - #{player1.show_state}"
  puts "1 - #{player2.show_state}"
  puts"----------------------------\n"
  choice = gets.chomp

  if choice == "a"
    user.search_weapon
  elsif choice == "s"
    user.search_health_pack
  elsif choice == "0"
    user.attacks(player1)
  elsif choice == "1"
    user.attacks(player2)
  end

  puts"----------------------------\n"
  puts "Les autres joueurs t'attaquent !"
  enemies.each do |enemie|
    if enemie.life_points <= 0
      break
    end
    enemie.attacks(user)
  end
  puts"----------------------------\n"
end

puts "La partie est finie"
  if user.life_points >= 0 && (player1.life_points <= 0 && player2.life_points <= 0)
    puts "BRAVO ! TU AS GAGNÉ !"
  else
    puts "Loser ! Tu as perdu"
  end