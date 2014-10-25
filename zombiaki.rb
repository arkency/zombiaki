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
    return if no_zombies_at_middle_street?
    if first_zombie_at_middle_street.one_life_left?
      kill_first_zombie_at_middle_street
    else
      first_zombie_at_middle_street.add_injury
    end
  end

  def make_shoot_at_left_street
    return if no_zombies_at_left_street?
    if first_zombie_at_left_street.one_life_left?
      kill_first_zombie_at_left_street
    else
      first_zombie_at_left_street.add_injury
    end
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

  def kill_first_zombie_at_left_street
    @left_street.clear_first_zombie
  end

  def kill_first_zombie_at_middle_street
    @middle_street.clear_first_zombie
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
