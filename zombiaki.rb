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

  def put_zombie_at_middle_street(zombie, block=4)
    @middle_street.put_zombie(block, zombie)
  end

  def put_zombie_at_left_street(zombie, block=4)
    @left_street.put_zombie(block, zombie)
  end

  def put_zombie_at_right_street(zombie, block=4)
    @right_street.put_zombie(block, zombie)
  end

  def put_car(street_index, block, car)
    place(street_index, block).put(car)
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
    @middle_street.no_zombie_at?(block)
  end

  def no_zombie_at_left_street?(block)
    @left_street.no_zombie_at?(block)
  end

  def no_zombie_at_right_street?(block)
    @left_street.no_zombie_at?(block)
  end

  def apply_effect_on_zombie(effect, zombie)
    effect.apply(zombie)
  end

  def apply_effect_on_street(street_index, effect)
    effect.apply(street_for_index(street_index))
  end

  def apply_pickaxe_on_place(street_index, block)
    PickAxeEffect.new.apply(place(street_index, block))
  end


  def place(street_index, block)
    street_for_index(street_index).at(block)
  end

  private


  def zombie_at_left_street(block)
    @left_street.at(block)
  end

  def zombie_at_middle_street(block)
    @middle_street.at(block)
  end
  def zombie_at_right_street(block)
    @right_street.at(block)
  end

  def street_for_index(street_index)
    case street_index
      when 0
        @left_street
      when 1
        @middle_street
      when 2
        @right_street
    end
  end
end

class Car
  def initialize(name)
    @name = name
  end
end

class SteroidsEffect
  def apply(zombie)
    zombie.restore_health
  end
end

class PickAxeEffect
  def apply(place)
    place.clear
  end
end

class StreetOnFireEffect
  def apply(street)

  end
end
