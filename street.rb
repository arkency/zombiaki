class Street
  def initialize
    @slots = Array.new(5)
  end

  def put_zombie(block, zombie)
    @slots[block] = zombie
  end

  def zombies
    @slots.select{|slot| slot != nil}
  end

  def clear_first_zombie
    @slots[@slots.index(zombies.first)] = nil
  end

  def at(block)
    @slots[block]
  end
end
