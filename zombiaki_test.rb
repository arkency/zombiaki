require 'test/unit'
require './zombiaki'


class ZombiesMoveForwardTestCase < Test::Unit::TestCase
  def test_zombies_turn_all_zombies_go
    app = ZombieGameApp.new
    app.apply_effect_on_place(0, 4, ThingAppearsOnPlace.new(Zombie.new(1, "griszka")))
    app.apply_effect_on_place(1, 4, ThingAppearsOnPlace.new(Zombie.new(1, "wladek")))
    app.apply_effect_on_place(2, 4, ThingAppearsOnPlace.new(Zombie.new(1, "misza" )))

    app.play_zombies_turn

    assert_equal("griszka", app.place(0, 3).name)
    assert_equal("wladek", app.place(1, 3).name)
    assert_equal("misza", app.place(2, 3).name)
    assert_equal(true, app.place(0, 4).empty?)
    assert_equal(true, app.place(1, 4).empty?)
    assert_equal(true, app.place(2, 4).empty?)
  end

  def test_zombies_dont_go_if_cars_are_blocking
    street = Street.new
    wladek = Zombie.new(lives=1, name="wladek")
    trabant = Car.new("trabant")
    street.put(4, wladek)
    street.put(0, trabant)

    street.move_zombies_forward

    assert_equal(wladek, street.at(4).thing)
    assert_equal(true, street.no_zombie_at?(3))
  end

  def test_zombies_can_go_if_cars_are_behind
    street = Street.new
    wladek = Zombie.new(lives=1, name="wladek")
    trabant = Car.new("trabant")
    street.put(2, wladek)
    street.put(3, trabant)

    street.move_zombies_forward

    assert_equal(wladek, street.at(1).thing)
    assert_equal(nil, street.at(2).thing)
  end
end

class HumansMoveTestCase < Test::Unit::TestCase
  def test_cars_go_forward
    street = Street.new
    trabant = Car.new("trabant")
    street.put(3, trabant)
    street.move_humans_forward

    assert_equal(trabant, street.at(4).thing)
    assert_equal(nil, street.at(3).thing)
  end
end

class ReflectorTestCase < Test::Unit::TestCase
  def test_reflector_moves_zombies_back
    street = Street.new
    wladek = Zombie.new
    street.put(3, wladek)
    street.use_reflector

    assert_equal(street.at(3).thing, nil)
    assert_equal(street.at(4).thing, wladek)
  end

  def test_doesnt_move_back_when_zombie_on_last_block
    street = Street.new
    wladek = Zombie.new
    street.put(4, wladek)
    street.use_reflector

    assert_equal(street.at(4).thing, wladek)
  end

  def test_zombie_cant_move_into_another_zombie_place
    street = Street.new
    wladek = Zombie.new
    griszka = Zombie.new

    street.put(4, wladek)
    street.put(3, griszka)

    street.use_reflector

    assert_equal(street.at(4).thing, wladek)
    assert_equal(street.at(3).thing, griszka)
  end
end

class ShootingAtStreetsTestCase < Test::Unit::TestCase

  def test_shoot_at_left_street_doesnt_kill_zombie_at_middle
    app = ZombieGameApp.new
    app.apply_effect_on_place(1, 4, ThingAppearsOnPlace.new(one_life_zombie("wladek")))
    app.apply_effect_on_street(0, ShootEffect.new)
    assert_equal("wladek", app.place(1, 4).name)
  end

  def test_shoot_at_middle_street_doesnt_kill_zombie_at_left
    app = ZombieGameApp.new
    app.apply_effect_on_place(0, 4, ThingAppearsOnPlace.new(one_life_zombie("wladek")))
    app.apply_effect_on_street(1, ShootEffect.new)
    assert_equal("wladek", app.place(0, 4).name)
  end


  def test_shoot_targets_first_zombie_on_the_left_street
    app = ZombieGameApp.new
    app.apply_effect_on_place(0, 4, ThingAppearsOnPlace.new(one_life_zombie("griszka")))
    app.apply_effect_on_place(0, 3, ThingAppearsOnPlace.new(one_life_zombie))
    app.apply_effect_on_street(0, ShootEffect.new)
    assert_equal(true, app.place(0, 3).empty?)
    assert_equal("griszka", app.place(0, 4).name)
  end

  def test_shoot_at_middle_street_doesnt_kill_zombie_at_right
    app = ZombieGameApp.new
    app.apply_effect_on_place(2, 4, ThingAppearsOnPlace.new(one_life_zombie("wladek")))
    app.apply_effect_on_street(1, ShootEffect.new)
    assert_equal("wladek", app.place(2, 4).name)
  end

  def test_shoot_targets_first_zombie_on_the_right_street
    app = ZombieGameApp.new
    app.apply_effect_on_place(2, 4, ThingAppearsOnPlace.new(one_life_zombie("griszka")))
    app.apply_effect_on_place(2, 3, ThingAppearsOnPlace.new(one_life_zombie))
    app.apply_effect_on_street(2, ShootEffect.new)
    assert_equal(true, app.place(2, 3).empty?)
    assert_equal("griszka", app.place(2, 4).name)
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
    street.put(4, wladek)
    street.put(3, griszka)
    street.make_shoot
    assert griszka.dead?
    assert ! wladek.dead?
  end

  def test_shoot_moves_back_if_alive
    street  = Street.new
    wladek  = Zombie.new(lives=2, name="wladek")
    street.put(3, wladek)
    street.make_shoot

    assert_equal(nil,    street.at(3).thing)
    assert_equal(wladek, street.at(4).thing)
  end

  def test_shoot_doesnt_move_back_if_borys
    street  = Street.new
    borys  = Zombie.new(lives=2, name="borys", moves_back_after_shoot=false)
    street.put(3, borys)
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
    app.apply_effect_on_place(1, 4, ThingAppearsOnPlace.new(wladek))

    app.apply_effect_on_zombie(SteroidsEffect.new, wladek)

    assert_equal(2, wladek.lives)
  end

  def test_make_zombie_healthy
    app = ZombieGameApp.new
    wladek = Zombie.new(lives=2)
    app.apply_effect_on_place(1, 4, ThingAppearsOnPlace.new(wladek))

    app.apply_effect_on_street(1, ShootEffect.new)
    assert_equal(1, wladek.lives)
    app.apply_effect_on_zombie(SteroidsEffect.new, wladek)

    assert_equal(2, wladek.lives)
  end
end

class PickaxeTestCase < Test::Unit::TestCase
  def test_have_no_effect_on_empy_place
    app = ZombieGameApp.new
    app.apply_effect_on_place(0, 0, PickAxeEffect.new)
  end

  def test_remove_a_car
    app = ZombieGameApp.new
    trabant = Car.new("trabant")
    app.apply_effect_on_place(0, 0, ThingAppearsOnPlace.new(trabant))
    app.apply_effect_on_place(0, 0, PickAxeEffect.new)

    assert_equal(true, app.place(0, 0).empty?)
  end
end

class StreetOnFire < Test::Unit::TestCase
  def test_no_effect_on_empty_street
    app = ZombieGameApp.new
    wladek = Zombie.new(lives=2)
    app.apply_effect_on_place(1, 4, ThingAppearsOnPlace.new(wladek))

    app.apply_effect_on_street(0, StreetOnFireEffect.new)

    assert_equal(2, wladek.lives)
  end

  def test_adds_one_injury_to_all_zombies_on_the_street
    app = ZombieGameApp.new
    wladek = Zombie.new(lives=2)
    griszka = Zombie.new(lives=1)
    app.apply_effect_on_place(1, 4, ThingAppearsOnPlace.new(wladek))
    app.apply_effect_on_place(1, 3, ThingAppearsOnPlace.new(griszka))

    app.apply_effect_on_street(1, StreetOnFireEffect.new)

    assert_equal(1, wladek.lives)
    assert_equal(0, griszka.lives)
  end
end

class FullGame < Test::Unit::TestCase
  def test_full_game
    zombie_stack = Stack.new
    wladek_1 = ThingAppearsOnPlace.new(Zombie.new(4, "wladek"))
    wladek_2 = ThingAppearsOnPlace.new(Zombie.new(4, "wladek"))
    griszka_1 = ThingAppearsOnPlace.new(Zombie.new(2, "griszka"))
    griszka_2 = ThingAppearsOnPlace.new(Zombie.new(2, "griszka"))
    zombie_stack << wladek_1
    zombie_stack << wladek_2
    zombie_stack << griszka_1
    zombie_stack << griszka_2
    zombie_stack << SteroidsEffect.new

    humans_stack = Stack.new
    shoot_1 = ShootEffect.new
    shoot_2 = ShootEffect.new
    shoot_3 = ShootEffect.new
    shoot_4 = ShootEffect.new

    humans_stack << shoot_1
    humans_stack << shoot_2
    humans_stack << shoot_3
    humans_stack << shoot_4

    game = ZombieGameApp.new(zombie_stack, humans_stack)

    game.zombies_take_cards_to_hand
    game.zombies_remove_card_to_trash(griszka_2)

    game.zombies_play_card(wladek_1, 0, 4)
    game.zombies_play_card(wladek_2, 2, 4)
    game.zombies_finish_move
    assert_equal(false, game.won_by_zombies?)

    game.humans_take_cards_to_hand
    game.humans_remove_card_to_trash(shoot_1)
    game.humans_play_card(shoot_2, 0, 0)
    game.humans_play_card(shoot_3, 1, 0)
    game.humans_finish_move

    game.play_zombies_turn
    #zombies now at 3
    game.zombies_take_cards_to_hand
    game.zombies_finish_move

    game.play_humans_turn
    game.humans_take_cards_to_hand
    game.humans_finish_move


    game.play_zombies_turn
    #zombies now at 2
    game.zombies_take_cards_to_hand
    game.zombies_finish_move

    game.play_humans_turn
    game.humans_take_cards_to_hand
    game.humans_finish_move


    game.play_zombies_turn
    #zombies now at 1
    game.zombies_take_cards_to_hand
    game.zombies_finish_move

    game.play_humans_turn
    game.humans_take_cards_to_hand
    game.humans_finish_move


    game.play_zombies_turn
    #zombies now at 0
    game.zombies_take_cards_to_hand
    game.zombies_finish_move

    game.play_humans_turn
    game.humans_take_cards_to_hand
    game.humans_finish_move


    game.play_zombies_turn
    assert_equal(true, game.won_by_zombies?)
  end
end
