class Player 
  attr_accessor :name, :life_points

  def initialize(name_to_save)
    @name = name_to_save
    @life_points = 10
  end

  def show_state
    puts "#{@name} à #{@life_points} de vie"
  end

  def gets_damage(damage)
    @life_points = @life_points - damage
    if @life_points <= 0
      puts "Le joueur #{@name} a été tué !"
    end
  end

  def attacks(player)
    puts "Le joueur #{@name} attaque le joueur #{player.name}"
    degat = compute_damage
    puts "Il lui inflige #{degat} points de dommages"
    player.gets_damage(degat)
  end

  def compute_damage
    return rand(1..6)
  end
end

class HumanPlayer < Player        #Définition de notre nouvelle classe de joueur
  attr_accessor :weapon_level

  def initialize(name_to_save)
    @weapon_level = 1
    super
    @life_points = 100  #On modifie les points de vie de l'humain
  end

  def show_state
    puts "#{@name} à #{@life_points} de vie et une de arme de niveau #{@weapon_level}"
  end

  def compute_damage
    rand(1..6) * @weapon_level
  end

  def search_weapon
    new_weapon_level = rand(1..6)     #On définit le niveau de l'arme aléatoirement
    puts "Tu as trouvé une arme de niveau #{new_weapon_level}"
    if new_weapon_level > @weapon_level
      puts "Bénef tu viens d'améliorer ton arme"
      @weapon_level = new_weapon_level
    else
      puts "Mince elle n'est pas mieux que ton arme actuelle"
    end
  end

  def search_health_pack
    health_pack = rand(1..6) 
    if health_pack == 1
      puts "Tu n'as rien trouvé ..."
    elsif 2 <= health_pack <= 5
      puts "Tu viens de trouvé un pack de 50 de vie"
      @life_points += 50
    elsif health_pack == 6
      puts "Waowwww tu viens de trouvé un pack de +80 points de vie!"
      @life_points += 80
    end
  end
end