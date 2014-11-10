require './zombie'
require './car'
require './street'
require './effects'
require './stack'
require './board'

class ZombieGameApp
  def initialize(zombies_stack=Stack.new, humans_stack=Stack.new)
    @board = Board.new(zombies_stack, humans_stack)

    @zombie_hand = Hand.new
    @zombie_trash = Stack.new
  end

  def zombies_take_cards_to_hand
    new_hand_cards = @board.zombies_stack.slice!(0, 4 - @zombie_hand.count) || []
    raise ZombieLost.new if new_hand_cards.detect{|card| card.class == Dawn}
    new_hand_cards.each {|card| @zombie_hand << card}
  end

  def zombies_remove_card_to_trash(card)
    @zombie_hand.remove(card)
    @zombie_trash << card
  end

  def zombies_play_card_on_place(card, street_index, block)
    raise CardsNotTakenToHand if @zombie_hand.count < 3
    raise CardNotRemoved if @zombie_hand.count == 4
    raise InvalidMove.new if card.class == ThingAppearsOnPlace && block != 5
    apply_effect_on_place(street_index, block, card)
  end


  def zombies_finish_move
  end

  def humans_take_cards_to_hand

  end

  def humans_remove_card_to_trash(card)

  end

  def humans_play_card(street_index, block, card)
  end

  def humans_finish_move

  end

  def won_by_zombies?
    @board.any_zombie_on_barricade?
  end

  def play_zombies_turn
    @board.streets.each{|street| street.move_zombies_forward}
  end

  def play_humans_turn
    @board.streets.each{|street| street.move_humans_forward}
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

class Hand
  def initialize
    @cards = []
  end
  def count
    @cards.count
  end

  def <<(card)
    @cards << card
  end

  def remove(card)
    @cards.delete(card)
  end
end


class ZombieLost < StandardError

end

class InvalidMove < StandardError
end

class CardNotRemoved < StandardError

end

class CardsNotTakenToHand < StandardError

end
