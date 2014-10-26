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
end
