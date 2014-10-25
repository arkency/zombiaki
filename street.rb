class Street
  def initialize
    @slots = Array.new(5)
  end

  def put_zombie(block, zombie)
    @slots[block] = zombie
  end

  def make_shoot
    return if no_zombies?
    first_zombie.hit
    clear_first_zombie if first_zombie.dead?
  end

  def move_zombies_forward
    zombies.each {|zombie| move_forward(zombie)}
  end

  def move_forward(zombie)
    current_block = current_block(zombie)
    clear_zombie_slot(zombie)
    put_zombie(current_block-1, zombie)
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
    clear_zombie_slot(first_zombie)
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

  private

  def clear_zombie_slot(zombie)
    @slots[current_block(zombie)] = nil
  end

  def current_block(zombie)
    @slots.index(zombie)
  end
end
