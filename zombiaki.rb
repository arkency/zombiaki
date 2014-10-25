require './zombie'
require './street'

class ZombieGameApp
  def initialize
    @left_street   = Street.new
    @middle_street = Street.new
  end

  def put_zombie_at_middle_street(zombie, block=5)
    @middle_street.put_zombie(block-1, zombie)
  end

  def put_zombie_at_left_street(zombie, block=5)
    @left_street.put_zombie(block-1, zombie)
  end

  def make_shoot_at_middle_street
    make_shoot(@middle_street)
  end

  def make_shoot_at_left_street
    make_shoot(@left_street)
  end

  def zombie_name_at_middle_street(block)
    zombie_at_middle_street(block).name
  end

  def zombie_name_at_left_street(block)
    zombie_at_left_street(block).name
  end

  def zombies_at_middle_street_count
    zombies_at_middle_street.count
  end

  def no_zombie_at_middle_street?(block)
    zombie_at_middle_street(block) == nil
  end

  def no_zombie_at_left_street?(block)
    true
  end

  private


  def make_shoot(street)
    return if street.no_zombies?
    if street.first_zombie.one_life_left?
      street.clear_first_zombie
    else
      street.injury_first_zombie
    end
  end

  def zombie_at_left_street(block)
    @left_street.at(block-1)
  end

  def zombie_at_middle_street(block)
    @middle_street.at(block-1)
  end

  def no_zombies_at_middle_street?
    first_zombie_at_middle_street == nil
  end

  def no_zombies_at_left_street?
    first_zombie_at_left_street == nil
  end

  def first_zombie_at_middle_street
    zombies_at_middle_street.first
  end

  def first_zombie_at_left_street
    zombies_at_left_street.first
  end

  def zombies_at_left_street
    @left_street.zombies
  end

  def zombies_at_middle_street
    @middle_street.zombies
  end

end
