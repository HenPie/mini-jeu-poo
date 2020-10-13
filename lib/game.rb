require_relative 'player'

class Game
  attr_accessor :human_player, :enemies_in_sight, :players_left

  def initialize(name)
    @human_player = HumanPlayer.new(name)
    @enemies_in_sight = []    #Array de Player qui sont ceux en vue
    @players_left = 10      #Nombre restant à éliminer pour gagner
  end

  def kill_player(player_to_kill)
    @enemies_in_sight.each do |enemie|
      if enemie.name == player_to_kill
        player_to_kill = enemie       #On affecte donc le nom du bot à tuer à enemie
        @enemies_in_sight.delete(enemie)
        @players_left = @players_left - 1     #On oublie pas de déduire le bot qu'on a tué
      end
    end
    puts "Il reste #{@players_left} enemies à tuer"
  end

  def is_still_ongoing?
    if @human_player.life_points > 0 && @players_left >= 0    #On vérifie que notre joueur est toujours en vie et qu'il reste des bots 
      return true
    else 
      return false
    end
  end

  def new_players_in_sight
    if @enemies_in_sight == @players_left
      puts "Tous les joueurs sont déjà en vue"
    end
    nb_players = rand(1..6) 
    if nb_players == 1
      puts "Aucun adversaire n'arrive"
    elsif nb_players.between?(2,4)
      player_name = "Joueur_#{rand(001..999)}"  #On définit le nom du bot aléatoirement dans une variable
      player_name = Player.new(player_name)   #On définit le nom du nouveau bot avec notre variable
      @enemies_in_sight << player_name        #On affecte ce nouveau bot à notre array de bots
      puts "Un nouvel adversaire débarque !"
    elsif nb_players == 5 || nb_players == 6
      2.times do 
        player_name = "Joueur_#{rand(001..999)}"
        player_name = Player.new(player_name)
        @enemies_in_sight << player_name
      end
      puts "Deux nouveaux combattants viennent d'arriver !"
    end
  end

  def show_players
    puts "#{@human_player.name} à #{@human_player.life_points} de vie"
    puts "Il reste #{@players_left} bots"
  end

  def menu
    puts"----------------------------\n"
    puts "Quelle action veux-tu effectuer ?"
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner"
    puts "Attquer un joueur en vue :"
    i = 0
    @enemies_in_sight.each do |enemie|
      print "#{i+1} - "
      puts enemie.name
      i += 1
    end
    puts"----------------------------\n"
  end

  def menu_choice(choice)
    if choice != "a" && choice != "s"
      choice = choice.to_i
    end

    if choice == "a"
      @human_player.search_weapon
    elsif choice == "s"
      @human_player.search_health_pack
    elsif choice.between?(1,enemies_in_sight.size) == true #Pour vérifier qu'on ne prend pas un numéro non existant
      choice = choice -1        #On retire un pour ne pas confondre avec un string qui possède un integer de 0
      @human_player.attacks(enemies_in_sight[choice])
      if enemies_in_sight[choice].life_points <= 0        #Vérification des points de vie du bot pour le supprimer s'il est mort
        puts "#{enemies_in_sight[choice].name} est mort"
        kill_player(enemies_in_sight[choice].name)
      else
        puts "#{enemies_in_sight[choice].name} a encore #{enemies_in_sight[choice].life_points} points de vie"
      end
    else 
      puts "Je ne comprends pas ce que tu veux"
    end
  end

  def enemies_attack
    puts"----------------------------\n"
    puts "Les autres joueurs t'attaquent !"
    @enemies_in_sight.each do |enemie|      #Si le bot est mort on ne souhaite plus qu'il attaque
      if enemie.life_points <= 0
        break
      end
      enemie.attacks(@human_player)
    end
    puts"----------------------------\n"
  end

  def end
    if @human_player.life_points <= 0
      puts "Loser ! Tu as perdu"
    else
      puts "BRAVO ! TU AS GAGNÉ !"
    end
  end
end