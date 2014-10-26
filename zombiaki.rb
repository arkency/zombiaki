require './zombie'
require './car'
require './street'
require './effects'
require './stack'
require './board'

class ZombieGameApp
  def initialize
    @board = Board.new
  end

  def play_zombies_turn
    @board.streets.each{|street| street.move_zombies_forward}
  end

  def apply_effect_on_zombie(effect, zombie)
    effect.apply(zombie)
  end

  def apply_effect_on_street(street_index, effect)
    effect.apply(@board.street_for_index(street_index))
  end

  def apply_effect_on_place(street_index, block, effect)
    effect.apply(place(street_index, block))
  end

  def place(street_index, block)
    @board.place(street_index, block)
  end

end

