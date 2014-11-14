class Stack
  def initialize
    @effects = []
  end

  def <<(new_effect)
    raise CardNameDuplicationDetected.new if @effects.detect{|effect| new_effect.name == effect.name}
    @effects << new_effect
  end

  def count
    @effects.count
  end

  def slice!(start_index, length)
    @effects.slice!(start_index, length)
  end
end

class CardNameDuplicationDetected < StandardError

end
