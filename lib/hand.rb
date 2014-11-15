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

  def include?(card)
    @cards.include?(card)
  end

  def card_by_name(name)
    card = @cards.detect {|card| card.name == name}
    raise NoSuchCard.new if card.nil?
    card
  end
end
