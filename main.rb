require 'test/unit'

class ZombiakiTestCase < Test::Unit::TestCase
  def test_main
    app = ZombieGameApp.new
    app.put_zombie_at_middle_street("wladek")
    assert_equal(1, app.zombies_at_middle_street().count)
    app.make_shoot_at_middle_street()
    assert_equal(0, app.zombies_at_middle_street().count)
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
    @zombies_at_middle_street.delete(@zombies_at_middle_street.last)
  end

  def zombies_at_middle_street
    @zombies_at_middle_street
  end
end
