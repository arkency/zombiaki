require 'test/unit'
require './zombiaki'


class ZombiesMoveForwardTestCase < Test::Unit::TestCase
  def test_zombies_turn_all_zombies_go
    app = ZombieGameApp.new
    app.put_zombie_at_left_street(Zombie.new(1, "griszka"), block=5)
    app.put_zombie_at_middle_street(Zombie.new(1, "wladek"), block=5)
    app.put_zombie_at_right_street(Zombie.new(1, "misza" ),  block=5)

    app.play_zombies_turn

    assert_equal("griszka", app.zombie_name_at_left_street(4))
    assert_equal("wladek", app.zombie_name_at_middle_street(4))
    assert_equal("misza", app.zombie_name_at_right_street(4))
    assert_equal(true, app.no_zombie_at_left_street?(5))
    assert_equal(true, app.no_zombie_at_middle_street?(5))
    assert_equal(true, app.no_zombie_at_right_street?(5))
  end

  def test_zombies_dont_go_if_cars_are_blocking
    street = Street.new
    wladek = Zombie.new(lives=1, name="wladek")
    trabant = Car.new("trabant")
    street.put_zombie(5, wladek)
    street.put_car(1, trabant)

    street.move_zombies_forward

    assert_equal(wladek, street.at(5))
    assert_equal(nil, street.at(4))
  end
end

class ShootingAtStreetsTestCase < Test::Unit::TestCase

  def test_shoot_at_left_street_doesnt_kill_zombie_at_middle
    app = ZombieGameApp.new
    app.put_zombie_at_middle_street(one_life_zombie("wladek"), block=5)
    app.make_shoot_at_left_street
    assert_equal("wladek", app.zombie_name_at_middle_street(5))
  end

  def test_shoot_at_middle_street_doesnt_kill_zombie_at_left
    app = ZombieGameApp.new
    app.put_zombie_at_left_street(one_life_zombie("wladek"), block=5)
    app.make_shoot_at_middle_street
    assert_equal("wladek", app.zombie_name_at_left_street(5))
  end


  def test_shoot_targets_first_zombie_on_the_left_street
    app = ZombieGameApp.new
    app.put_zombie_at_left_street(one_life_zombie("griszka"), block=5)
    app.put_zombie_at_left_street(one_life_zombie, block=4)
    app.make_shoot_at_left_street
    assert_equal(true, app.no_zombie_at_left_street?(4))
    assert_equal("griszka", app.zombie_name_at_left_street(5))
  end

  def test_shoot_at_middle_street_doesnt_kill_zombie_at_right
    app = ZombieGameApp.new
    app.put_zombie_at_right_street(one_life_zombie("wladek"), block=5)
    app.make_shoot_at_middle_street
    assert_equal("wladek", app.zombie_name_at_right_street(5))
  end

  def test_shoot_targets_first_zombie_on_the_right_street
    app = ZombieGameApp.new
    app.put_zombie_at_right_street(one_life_zombie("griszka"), block=5)
    app.put_zombie_at_right_street(one_life_zombie, block=4)
    app.make_shoot_at_right_street
    assert_equal(true, app.no_zombie_at_right_street?(4))
    assert_equal("griszka", app.zombie_name_at_right_street(5))
  end

  private

  def one_life_zombie(name="zombie")
    Zombie.new(lives=1, name=name)
  end

  def two_lives_zombie
    Zombie.new(lives=2)
  end

end

class StreetTestCase < Test::Unit::TestCase
  def test_shoot_targets_first_zombie_on_the_midle_street
    street  = Street.new
    wladek  = Zombie.new(lives=1, name="wladek")
    griszka = Zombie.new(lives=1, name="griszka")
    street.put_zombie(4, wladek)
    street.put_zombie(3, griszka)
    street.make_shoot
    assert griszka.dead?
    assert ! wladek.dead?
  end
end

class ZombieTestCase < Test::Unit::TestCase
  def test_zombie_dies_after_shot
    zombie = Zombie.new
    zombie.hit
    assert zombie.dead?
  end

  def test_2_lives_zombie_survives_one_shot
    zombie = Zombie.new(lives=2)
    zombie.hit
    assert ! zombie.dead?
  end

  def test_2_lives_zombie_dies_after_two_shots
    zombie = Zombie.new(lives=2)
    zombie.hit
    zombie.hit
    assert zombie.dead?
  end
end

