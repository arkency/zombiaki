class Board
  attr_reader :zombies_stack, :humans_stack, :streets

  def initialize
    @streets = [Street.new, Street.new, Street.new]
  end

  def street_for_index(street_index)
    @streets[street_index]
  end

  def place(street_index, block)
    street_for_index(street_index).at(block)
  end

  def any_zombie_on_barricade?
    ! @streets.detect{|street| street.zombie_at_barricade?}.nil?
  end

  def move_zombies_forward
    @streets.each{|street| street.move_zombies_forward}
  end
end
