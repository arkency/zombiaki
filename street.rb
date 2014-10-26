class Street
  def initialize
    @places = [Place.new, Place.new, Place.new, Place.new, Place.new]
  end

  def put_zombie(block, zombie)
    @places[block].put(zombie)
  end

  def put_car(block, car)
    @places[block].put(car)
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
    @places.select{|place| ! place.empty? && place.thing.class == Zombie}.map(&:thing)
  end

  def cars
    @places.select{|place| ! place.empty? && place.thing.class == Car}.map(&:thing)
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
    at(block).thing.class == Zombie
  end

  def no_zombie_at?(block)
    at(block).thing.class != Zombie
  end

  private

  def clear_slot(slot)
    @places[current_block(slot)].clear
  end

  def current_block(zombie)
    @places.index(@places.detect{|place| place.thing == zombie})
  end

  def car_blocking?(zombie)
    @places.detect{|place| place.thing.class == Car && (@places.index(place) < current_block(zombie))}
  end

  def cant_move_back?(current_block, zombie)
    current_block(zombie) == 4 or zombie_at?(current_block+1)
  end
end

class Place
  def initialize
    @thing = nil
  end

  def put(thing)
    @thing = thing
  end

  def thing
    @thing
  end

  def clear
    @thing = nil
  end

  def empty?
    @thing == nil
  end

  def name
    return "nil" if empty?
    return @thing.name
  end
end
