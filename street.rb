class Street
  def initialize
    @slots = Array.new(5)
  end

  def put_zombie(block, zombie)
    @slots[block] = zombie
  end

  def make_shoot
    return if no_zombies?
    if first_zombie.one_life_left?
      clear_first_zombie
    else
      injury_first_zombie
    end
  end

  def zombies
    @slots.select{|slot| slot != nil}
  end

  def zombies_count
    zombies.count
  end

  def no_zombies?
    zombies == []
  end

  def first_zombie
    zombies.first
  end

  def clear_first_zombie
    @slots[@slots.index(zombies.first)] = nil
  end

  def injury_first_zombie
    first_zombie.add_injury
  end

  def at(block)
    @slots[block]
  end

  def no_zombie_at?(block)
    at(block) == nil
  end
end
