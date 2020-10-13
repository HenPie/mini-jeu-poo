require 'bundler'
Bundler.require

# lignes qui appellent les fichiers lib/user.rb et lib/event.rb
# comme ça, tu peux faire User.new dans ce fichier d'application. Top.
require_relative 'lib/game'
require_relative 'lib/player'

player1 = Player.new("Josiane")
player2 = Player.new("José")


while player1.life_points > 0 && player2.life_points > 0
  puts"--------------\n"
  puts "Voici l'état de chaque joueur :"
  player1.show_state
  player2.show_state
  puts"--------------\n"
  puts "Passons à la phase d'attaque !"
  player1.attacks(player2)
  if player2.life_points <= 0 
    break
  end
  player2.attacks(player1)
end

