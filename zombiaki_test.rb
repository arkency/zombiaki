require 'test/unit'
require './zombiaki'

class ZombiakiTestCase < Test::Unit::TestCase
  def test_zombie_dies_after_shot
    app = ZombieGameApp.new
    app.put_zombie_at_middle_street(one_life_zombie)
    assert_1_zombie_at_middle_street(app)
    app.make_shoot_at_middle_street
    assert_0_zombies_left(app)
  end

  def test_2_lives_zombie_survives_one_shot
    app = ZombieGameApp.new
    app.put_zombie_at_middle_street(two_lives_zombie)
    app.make_shoot_at_middle_street
    assert_1_zombie_at_middle_street(app)
  end

  def test_2_lives_zombie_dies_after_two_shots
    app = ZombieGameApp.new
    app.put_zombie_at_middle_street(two_lives_zombie)
    app.make_shoot_at_middle_street
    app.make_shoot_at_middle_street
    assert_0_zombies_left(app)
  end

  def test_shoot_targets_first_zombie_on_the_street
    app = ZombieGameApp.new
    app.put_zombie_at_middle_street(one_life_zombie("wladek"), block=5)
    app.put_zombie_at_middle_street(one_life_zombie, block=4)
    app.make_shoot_at_middle_street
    assert_equal(true, app.no_zombie_at_middle_street?(4))
    assert_equal("wladek", app.zombie_name_at_middle_street(5))
  end

  def test_shoot_at_left_street_doesnt_kill_zombie_at_middle
    app = ZombieGameApp.new
    app.put_zombie_at_middle_street(one_life_zombie("wladek"), block=5)
    app.make_shoot_at_left_street
    assert_equal("wladek", app.zombie_name_at_middle_street(5))
  end

  private

  def one_life_zombie(name="zombie")
    Zombie.new(lives=1, name=name)
  end

  def two_lives_zombie
    Zombie.new(lives=2)
  end

  def assert_0_zombies_left(app)
    assert_equal(0, app.zombies_at_middle_street_count)
  end

  def assert_1_zombie_at_middle_street(app)
    assert_equal(1, app.zombies_at_middle_street_count)
  end
end

