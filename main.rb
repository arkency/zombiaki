class Zombie
  def initialize(lives=1, name="zombie")
    @lives = lives
    @name  = name
  end

  def name
    @name
  end

  def one_life_left?
    @lives == 1
  end

  def add_injury
    @lives -= 1
  end
end

class ZombieGameApp
  def initialize
    @zombies_at_middle_street = Array.new(5)
  end

  def put_zombie_at_middle_street(zombie, block=5)
    @zombies_at_middle_street[block-1] = zombie
  end

  def make_shoot_at_middle_street
    return if no_zombies_at_middle_street?
    if first_zombie_at_middle_street.one_life_left?
      kill_first_zombie
    else
      first_zombie_at_middle_street.add_injury
    end
  end

  def zombie_name_at_middle_street(block)
    zombie_at_middle_street(block).name
  end

  def zombies_at_middle_street_count
    zombies_at_middle_street.count
  end

  def no_zombie_at_middle_street?(block)
    zombie_at_middle_street(block) == nil
  end

  private

  def kill_first_zombie
    @zombies_at_middle_street[@zombies_at_middle_street.index(first_zombie_at_middle_street)] = nil
  end


  def zombie_at_middle_street(block)
    @zombies_at_middle_street[block-1]
  end

  def no_zombies_at_middle_street?
    first_zombie_at_middle_street == nil
  end

  def first_zombie_at_middle_street
    zombies_at_middle_street.first
  end

  def zombies_at_middle_street
    @zombies_at_middle_street.select { |slot| slot != nil }
  end

end
