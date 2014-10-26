class Street
  def initialize
    @places = Array.new(5, Place.new)
  end

  def put_zombie(block, zombie)
    @places[block] = zombie
  end

  def put_car(block, car)
    @places[block] = car
  end

  def make_shoot
    return if no_zombies?
    first_zombie.hit
    move_zombie_back(first_zombie) if first_zombie.can_move_back?
    clear_first_zombie             if first_zombie.dead?
  end

  def use_reflector
    zombies.reverse.each {|zombie| move_zombie_back(zombie)}
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
    return if cant_move_back?(current_block, zombie)
    clear_slot(zombie)
    put_zombie(current_block+1, zombie)
  end

  def zombies
    @places.select{|slot| slot != nil && slot.class == Zombie}
  end

  def cars
    @places.select{|slot| slot != nil && slot.class == Car}
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
    @places[block]
  end

  def zombie_at?(block)
    at(block).class == Zombie
  end

  def no_zombie_at?(block)
    at(block).class != Zombie
  end

  private

  def clear_slot(slot)
    @places[current_block(slot)] = nil
  end

  def current_block(zombie)
    @places.index(zombie)
  end

  def car_blocking?(zombie)
    @places.detect{|slot| slot.class == Car && (@places.index(slot) < current_block(zombie))}
  end

  def cant_move_back?(current_block, zombie)
    current_block(zombie) == 5 or zombie_at?(current_block+1)
  end
end

class Place

end
