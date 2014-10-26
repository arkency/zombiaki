require 'test/unit'
require './zombiaki'


class ZombiesMoveForwardTestCase < Test::Unit::TestCase
  def test_zombies_turn_all_zombies_go
    app = ZombieGameApp.new
    app.put_zombie_at_left_street(Zombie.new(1, "griszka"), block=4)
    app.put_zombie_at_middle_street(Zombie.new(1, "wladek"), block=4)
    app.put_zombie_at_right_street(Zombie.new(1, "misza" ),  block=4)

    app.play_zombies_turn

    assert_equal("griszka", app.zombie_name_at_left_street(3))
    assert_equal("wladek", app.zombie_name_at_middle_street(3))
    assert_equal("misza", app.zombie_name_at_right_street(3))
    assert_equal(true, app.no_zombie_at_left_street?(4))
    assert_equal(true, app.no_zombie_at_middle_street?(4))
    assert_equal(true, app.no_zombie_at_right_street?(4))
  end

  def test_zombies_dont_go_if_cars_are_blocking
    street = Street.new
    wladek = Zombie.new(lives=1, name="wladek")
    trabant = Car.new("trabant")
    street.put_zombie(4, wladek)
    street.put_car(0, trabant)

    street.move_zombies_forward

    assert_equal(wladek, street.at(4).thing)
    assert_equal(true, street.no_zombie_at?(3))
  end

  def test_zombies_can_go_if_cars_are_behind
    street = Street.new
    wladek = Zombie.new(lives=1, name="wladek")
    trabant = Car.new("trabant")
    street.put_zombie(2, wladek)
    street.put_car(3, trabant)

    street.move_zombies_forward

    assert_equal(wladek, street.at(1).thing)
    assert_equal(nil, street.at(2).thing)
  end
end

class HumansMoveTestCase < Test::Unit::TestCase
  def test_cars_go_forward
    street = Street.new
    trabant = Car.new("trabant")
    street.put_car(3, trabant)
    street.move_humans_forward

    assert_equal(trabant, street.at(4).thing)
    assert_equal(nil, street.at(3).thing)
  end
end

class ReflectorTestCase < Test::Unit::TestCase
  def test_reflector_moves_zombies_back
    street = Street.new
    wladek = Zombie.new
    street.put_zombie(3, wladek)
    street.use_reflector

    assert_equal(street.at(3).thing, nil)
    assert_equal(street.at(4).thing, wladek)
  end

  def test_doesnt_move_back_when_zombie_on_last_block
    street = Street.new
    wladek = Zombie.new
    street.put_zombie(4, wladek)
    street.use_reflector

    assert_equal(street.at(4).thing, wladek)
  end

  def test_zombie_cant_move_into_another_zombie_place
    street = Street.new
    wladek = Zombie.new
    griszka = Zombie.new

    street.put_zombie(4, wladek)
    street.put_zombie(3, griszka)

    street.use_reflector

    assert_equal(street.at(4).thing, wladek)
    assert_equal(street.at(3).thing, griszka)
  end
end

class ShootingAtStreetsTestCase < Test::Unit::TestCase

  def test_shoot_at_left_street_doesnt_kill_zombie_at_middle
    app = ZombieGameApp.new
    app.put_zombie_at_middle_street(one_life_zombie("wladek"), block=4)
    app.make_shoot_at_left_street
    assert_equal("wladek", app.zombie_name_at_middle_street(4))
  end

  def test_shoot_at_middle_street_doesnt_kill_zombie_at_left
    app = ZombieGameApp.new
    app.put_zombie_at_left_street(one_life_zombie("wladek"), block=4)
    app.make_shoot_at_middle_street
    assert_equal("wladek", app.zombie_name_at_left_street(4))
  end


  def test_shoot_targets_first_zombie_on_the_left_street
    app = ZombieGameApp.new
    app.put_zombie_at_left_street(one_life_zombie("griszka"), block=4)
    app.put_zombie_at_left_street(one_life_zombie, block=3)
    app.make_shoot_at_left_street
    assert_equal(true, app.no_zombie_at_left_street?(3))
    assert_equal("griszka", app.zombie_name_at_left_street(4))
  end

  def test_shoot_at_middle_street_doesnt_kill_zombie_at_right
    app = ZombieGameApp.new
    app.put_zombie_at_right_street(one_life_zombie("wladek"), block=4)
    app.make_shoot_at_middle_street
    assert_equal("wladek", app.zombie_name_at_right_street(4))
  end

  def test_shoot_targets_first_zombie_on_the_right_street
    app = ZombieGameApp.new
    app.put_zombie_at_right_street(one_life_zombie("griszka"), block=4)
    app.put_zombie_at_right_street(one_life_zombie, block=3)
    app.make_shoot_at_right_street
    assert_equal(true, app.no_zombie_at_right_street?(3))
    assert_equal("griszka", app.zombie_name_at_right_street(4))
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

  def test_shoot_moves_back_if_alive
    street  = Street.new
    wladek  = Zombie.new(lives=2, name="wladek")
    street.put_zombie(3, wladek)
    street.make_shoot

    assert_equal(nil,    street.at(3).thing)
    assert_equal(wladek, street.at(4).thing)
  end

  def test_shoot_doesnt_move_back_if_borys
    street  = Street.new
    borys  = Zombie.new(lives=2, name="borys", moves_back_after_shoot=false)
    street.put_zombie(3, borys)
    street.make_shoot

    assert_equal(borys, street.at(3).thing)
    assert_equal(nil,   street.at(4).thing)
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

class SteroidsTestCase < Test::Unit::TestCase
  def test_have_no_effect_on_zombie_without_injuries
    app = ZombieGameApp.new
    wladek = Zombie.new(lives=2)
    app.put_zombie_at_middle_street(wladek, 4)

    app.apply_steroids_on(wladek)

    assert_equal(2, wladek.lives)
  end
end

