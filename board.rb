class Board
  attr_reader :zombies_stack, :humans_stack, :streets

  def initialize(zombies_stack, humans_stack)
    @streets = [Street.new, Street.new, Street.new]

    @zombies_stack = zombies_stack
    @humans_stack  = humans_stack
  end

  def generate_stacks
    @zombies_stack << PickAxeEffect.new
    @humans_stack  << StreetOnFireEffect.new
  end

  def street_for_index(street_index)
    @streets[street_index]
  end

  def place(street_index, block)
    street_for_index(street_index).at(block)
  end
end
