class Street
  def initialize
    @slots = Array.new(5)
  end

  def put_zombie(block, zombie)
    @slots[block] = zombie
  end

  def put_car(block, car)
    @slots[block] = car
  end

  def make_shoot
    return if no_zombies?
    first_zombie.hit
    move_zombie_back(first_zombie) if first_zombie.can_move_back?
    clear_first_zombie             if first_zombie.dead?
  end

  def move_zombies_forward
    move_all_zombies
  end

  def move_humans_forward
    cars.each {|car| move_car_forward(car)}
  end

  def move_all_zombies
    zombies.each { |zombie| move_forward(zombie) unless car_blocking?(zombie)}
  end

  def move_forward(zombie)
    current_block = current_block(zombie)
    clear_slot(zombie)
    put_zombie(current_block-1, zombie)
  end

  def move_car_forward(car)
    current_block = current_block(car)
    clear_slot(car)
    put_car(current_block+1, car)
  end

  def move_zombie_back(zombie)
    current_block = current_block(zombie)
    clear_slot(zombie)
    put_zombie(current_block+1, zombie)
  end

  def zombies
    @slots.select{|slot| slot != nil && slot.class == Zombie}
  end

  def cars
    @slots.select{|slot| slot != nil && slot.class == Car}
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
    clear_slot(first_zombie)
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

  def clear_slot(slot)
    @slots[current_block(slot)] = nil
  end

  def current_block(zombie)
    @slots.index(zombie)
  end

  def car_blocking?(zombie)
    @slots.detect{|slot| slot.class == Car && (@slots.index(slot) < current_block(zombie))}
  end
end
