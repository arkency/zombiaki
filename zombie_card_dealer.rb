class ZombieCardDealer

  def basic_zombies
    zombie_stack = Stack.new
    zombie_stack << ThingAppearsOnPlace.new(Zombie.new(4, "wladek_1"))
    zombie_stack << ThingAppearsOnPlace.new(Zombie.new(4, "wladek_2"))
    zombie_stack << ThingAppearsOnPlace.new(Zombie.new(2, "griszka_1"))
    zombie_stack << ThingAppearsOnPlace.new(Zombie.new(2, "griszka_2"))
    zombie_stack << Dawn.new
    zombie_stack
  end

  def zombie_stack
    zombie_stack = Stack.new
    wladek_1 = ThingAppearsOnPlace.new(Zombie.new(4, "wladek_1"))
    wladek_2 = ThingAppearsOnPlace.new(Zombie.new(4, "wladek_2"))
    griszka_1 = ThingAppearsOnPlace.new(Zombie.new(2, "griszka_1"))
    griszka_2 = ThingAppearsOnPlace.new(Zombie.new(2, "griszka_2"))
    griszka_3 = ThingAppearsOnPlace.new(Zombie.new(2, "griszka_3"))
    griszka_4 = ThingAppearsOnPlace.new(Zombie.new(2, "griszka_4"))
    griszka_5 = ThingAppearsOnPlace.new(Zombie.new(2, "griszka_5"))
    griszka_6 = ThingAppearsOnPlace.new(Zombie.new(2, "griszka_6"))
    griszka_7 = ThingAppearsOnPlace.new(Zombie.new(2, "griszka_7"))

    zombie_stack << wladek_1
    zombie_stack << wladek_2
    zombie_stack << griszka_1
    zombie_stack << griszka_2
    zombie_stack << griszka_3
    zombie_stack << griszka_4
    zombie_stack << griszka_5
    zombie_stack << griszka_6
    zombie_stack << griszka_7
    return zombie_stack
  end

  def human_stack
    humans_stack = Stack.new
    shoot_1 = ShootEffect.new("shoot_1")
    shoot_2 = ShootEffect.new("shoot_2")
    shoot_3 = ShootEffect.new("shoot_3")
    shoot_4 = ShootEffect.new("shoot_4")
    shoot_5 = ShootEffect.new("shoot_5")
    shoot_6 = ShootEffect.new("shoot_6")
    shoot_7 = ShootEffect.new("shoot_7")
    shoot_8 = ShootEffect.new("shoot_8")

    humans_stack << shoot_1
    humans_stack << shoot_2
    humans_stack << shoot_3
    humans_stack << shoot_4
    humans_stack << shoot_5
    humans_stack << shoot_6
    humans_stack << shoot_7
    humans_stack << shoot_8
    return humans_stack
  end
end
