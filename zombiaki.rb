require './zombie'
require './car'
require './street'
require './effects'
require './stack'

class ZombieGameApp
  def initialize
    @left_street   = Street.new
    @middle_street = Street.new
    @right_street = Street.new
    @streets = [@left_street, @middle_street, @right_street]

    @zombies_stack = Stack.new
    @humans_stack  = Stack.new
  end

  def zombies_stack
    @zombies_stack
  end

  def humans_stack
    @humans_stack
  end

  def generate_stacks
    @zombies_stack << PickAxeEffect.new
    @humans_stack  << StreetOnFireEffect.new
  end

  def play_zombies_turn
    @streets.each{|street| street.move_zombies_forward}
  end

  def put(zombie, street_index, block=4)
    street_for_index(street_index).put(block, zombie)
  end

  def make_shoot(street_index)
    street_for_index(street_index).make_shoot
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

