require 'test/unit'

class ZombiakiTestCase < Test::Unit::TestCase
  def test_zombie_dies_after_shot
    app = ZombieGameApp.new
    app.put_zombie_at_middle_street(Zombie.new(lives=1))
    assert_equal(1, app.zombies_at_middle_street().count)
    app.make_shoot_at_middle_street()
    assert_equal(0, app.zombies_at_middle_street().count)
  end

  def test_2_lives_zombie_survives_one_shot
    app = ZombieGameApp.new
    app.put_zombie_at_middle_street(Zombie.new(lives=2))
    app.make_shoot_at_middle_street()
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
    end
  end

  def zombies_at_middle_street
    @zombies_at_middle_street
  end
end
