require './zombie'
require './street'

class ZombieGameApp
  def initialize
    @left_street   = Street.new
    @middle_street = Street.new
    @right_street = Street.new
    @streets = [@left_street, @middle_street, @right_street]
  end

  def play_zombies_turn
    @streets.each{|street| street.move_zombies_forward}
  end

  def put_zombie_at_middle_street(zombie, block=5)
    @middle_street.put_zombie(block-1, zombie)
  end

  def put_zombie_at_left_street(zombie, block=5)
    @left_street.put_zombie(block-1, zombie)
  end

  def put_zombie_at_right_street(zombie, block=5)
    @right_street.put_zombie(block-1, zombie)
  end

  def make_shoot_at_middle_street
    @middle_street.make_shoot
  end

  def make_shoot_at_left_street
    @left_street.make_shoot
  end


  def make_shoot_at_right_street
    @right_street.make_shoot
  end

  def zombie_name_at_middle_street(block)
    zombie_at_middle_street(block).name
  end

  def zombie_name_at_left_street(block)
    zombie_at_left_street(block).name
  end

  def zombie_name_at_right_street(block)
    zombie_at_right_street(block).name
  end

  def zombies_at_middle_street_count
    @middle_street.zombies_count
  end

  def no_zombie_at_middle_street?(block)
    @middle_street.no_zombie_at?(block-1)
  end

  def no_zombie_at_left_street?(block)
    @left_street.no_zombie_at?(block-1)
  end

  def no_zombie_at_right_street?(block)
    @left_street.no_zombie_at?(block-1)
  end

  private

  def zombie_at_left_street(block)
    @left_street.at(block-1)
  end

  def zombie_at_middle_street(block)
    @middle_street.at(block-1)
  end


  def zombie_at_right_street(block)
    @right_street.at(block-1)
  end


end
