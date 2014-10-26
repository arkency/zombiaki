require './zombie'
require './car'
require './street'
require './effects'
require './stack'

class ZombieGameApp
  def initialize
    @streets = [Street.new, Street.new, Street.new]

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

  def zombie_name(street_index, block)
    street_for_index(street_index).at(block).name
  end

  def no_zombie_at?(street_index, block)
    street_for_index(street_index).no_zombie_at?(block)
  end

  def apply_effect_on_zombie(effect, zombie)
    effect.apply(zombie)
  end

  def apply_effect_on_street(street_index, effect)
    effect.apply(street_for_index(street_index))
  end

  def apply_effect_on_place(street_index, block, effect)
    effect.apply(place(street_index, block))
  end

  def place(street_index, block)
    street_for_index(street_index).at(block)
  end

  private

  def street_for_index(street_index)
    @streets[street_index]
  end
end

