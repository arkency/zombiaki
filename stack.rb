class Stack
  def initialize
    @effects = []
  end

  def <<(effect)
    @effects << effect
  end

  def count
    @effects.count
  end

  def slice!(start_index, length)
    @effects.slice!(start_index, length)
  end
end
