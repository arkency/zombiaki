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

  def has_car?
    thing.class == Car
  end

  def has_zombie?
    thing.class == Zombie
  end

  def no_zombie?
    ! has_zombie?
  end
end
