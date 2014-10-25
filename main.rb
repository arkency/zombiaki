require 'test/unit'

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
    assert_equal(nil, app.zombie_at_middle_street(4))
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


class Zombie
  def initialize(lives=1, name="zombie")
    @lives = lives
    @name  = name
  end

  def name
    @name
  end

  def one_life_left?
    @lives == 1
  end

  def add_injury
    @lives -= 1
  end
end

class ZombieGameApp
  def initialize
    @zombies_at_middle_street = Array.new(5)
  end

  def put_zombie_at_middle_street(zombie, block=5)
    @zombies_at_middle_street[block-1] = zombie
  end

  def make_shoot_at_middle_street
    return if no_zombies_at_middle_street?
    if first_zombie_at_middle_street.one_life_left?
      @zombies_at_middle_street[@zombies_at_middle_street.index(first_zombie_at_middle_street)] = nil
    else
      first_zombie_at_middle_street.add_injury
    end
  end

  def no_zombies_at_middle_street?
    first_zombie_at_middle_street == nil
  end

  def first_zombie_at_middle_street
    zombies_at_middle_street.first
  end

  def zombies_at_middle_street_count
    zombies_at_middle_street.count
  end

  def zombies_at_middle_street
    @zombies_at_middle_street.select { |slot| slot != nil }
  end

  def zombie_name_at_middle_street(block)
    zombie_at_middle_street(block).name
  end

  def zombie_at_middle_street(block)
    @zombies_at_middle_street[block-1]
  end
end
