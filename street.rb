require './place'

class Street
  def initialize
    @barricade = Place.new
    @places = [@barricade, Place.new, Place.new, Place.new, Place.new, Place.new]
  end

  def put(block, thing)
    @places[block].put(thing)
  end

  def zombie_at_barricade?
    @barricade.has_zombie?
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
    clear_place(zombie)
    put(current_block-1, zombie)
  end

  def move_car_forward(car)
    current_block = current_block(car)
    clear_place(car)
    put(current_block+1, car)
  end

  def move_zombie_back(zombie)
    current_block = current_block(zombie)
    return if cant_move_back?(current_block, zombie)
    clear_place(zombie)
    put(current_block+1, zombie)
  end

  def zombies
    @places.select{|place| place.has_zombie?}.map(&:thing)
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
    clear_place(first_zombie)
  end

  def injury_first_zombie
    first_zombie.add_injury
  end

  def at(block)
    @places[block]
  end

  def zombie_at?(block)
    at(block).has_zombie?
  end

  def no_zombie_at?(block)
    at(block).no_zombie?
  end

  private

  def clear_place(slot)
    @places[current_block(slot)].clear
  end

  def current_block(zombie)
    @places.index(@places.detect{|place| place.thing == zombie})
  end

  def car_blocking?(zombie)
    @places.detect{|place| car_in_front_of_zombie?(place, zombie)}
  end

  def car_in_front_of_zombie?(place, zombie)
    place.has_car? && place_in_front_of_zombie?(place, zombie)
  end

  def place_in_front_of_zombie?(place, zombie)
    @places.index(place) < current_block(zombie)
  end

  def cant_move_back?(current_block, zombie)
    current_block(zombie) == 4 or zombie_at?(current_block+1)
  end
end


