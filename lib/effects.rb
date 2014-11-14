class SteroidsEffect
  def apply(zombie)
    zombie.restore_health
  end
end

class PickAxeEffect
  def apply(place)
    place.clear
  end
end

class StreetOnFireEffect
  def apply(street)
    street.zombies.each {|zombie| zombie.hit}
  end
end

class ShootEffect
  def initialize(name = "shoot")
    @name = name
  end

  def apply(street)
    street.make_shoot
  end

  def name
    @name
  end
end

class ThingAppearsOnPlace
  def initialize(thing)
    @thing = thing
  end

  def apply(place)
    place.put(@thing)
  end

  def name
    @thing.name
  end
end

class Dawn
  def name
    "dawn"
  end
end
