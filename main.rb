require 'test/unit'

class ZombiakiTestCase < Test::Unit::TestCase
  def test_zombie_dies_after_shot
    app = ZombieGameApp.new
    app.put_zombie_at_middle_street(one_life_zombie)
    assert_1_zombie_at_middle_street(app)
    app.make_shoot_at_middle_street()
    assert_0_zombies_left(app)
  end

  def test_2_lives_zombie_survives_one_shot
    app = ZombieGameApp.new
    app.put_zombie_at_middle_street(two_lives_zombie)
    app.make_shoot_at_middle_street()
    assert_1_zombie_at_middle_street(app)
  end

  def test_2_lives_zombie_dies_after_two_shots
    app = ZombieGameApp.new
    app.put_zombie_at_middle_street(two_lives_zombie)
    app.make_shoot_at_middle_street()
    app.make_shoot_at_middle_street()
    assert_0_zombies_left(app)
  end

  private

  def one_life_zombie
    Zombie.new(lives=1)
  end

  def two_lives_zombie
    Zombie.new(lives=2)
  end

  def assert_0_zombies_left(app)
    assert_equal(0, app.zombies_at_middle_street().count)
  end

  def assert_1_zombie_at_middle_street(app)
    assert_equal(1, app.zombies_at_middle_street().count)
  end
end


class Zombie
  def initialize(lives=1)
    @lives = lives
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
    @zombies_at_middle_street = []
  end

  def put_zombie_at_middle_street(zombie)
    @zombies_at_middle_street << zombie
  end

  def make_shoot_at_middle_street
    if @zombies_at_middle_street.first.one_life_left?
      @zombies_at_middle_street.delete(@zombies_at_middle_street.last)
    else
      @zombies_at_middle_street.last.add_injury
    end
  end

  def zombies_at_middle_street
    @zombies_at_middle_street
  end
end
