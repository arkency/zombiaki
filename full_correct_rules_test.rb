class CorrectRules < Test::Unit::TestCase
  def test_zombies_only_start_at_5th_row
    game = ZombieGame.new(ZombieCardDealer.new.basic_zombies, Stack.new)
    game.play_zombies_turn
    game.zombies_take_cards_to_hand
    game.zombies_remove_card_to_trash("griszka_1")
    assert_raises InvalidMove do
      game.zombies_play_card_on_place("wladek_1", 0, 4)
    end
  end

  def test_zombies_have_to_remove_card_to_trash
    game = ZombieGame.new(ZombieCardDealer.new.basic_zombies, Stack.new)
    game.play_zombies_turn
    game.zombies_take_cards_to_hand
    assert_raises CardNotRemoved do
      game.zombies_play_card_on_place("wladek_1", 0, 5)
    end
  end

  def test_zombies_need_to_take_cards_to_hand_before_playing
    game = ZombieGame.new(ZombieCardDealer.new.basic_zombies, Stack.new)
    game.play_zombies_turn
    assert_raises NoSuchCard do
      game.zombies_play_card_on_place("wladek", 0, 5)
    end
  end

  def test_zombies_need_to_take_cards_to_hand_before_removing
    game = ZombieGame.new(ZombieCardDealer.new.basic_zombies, Stack.new)
    game.play_zombies_turn
    assert_raises NoSuchCard do
      game.zombies_remove_card_to_trash("griszka_1")
    end
  end

  def test_humans_need_to_remove_card_before_playing
    humans_stack = Stack.new
    humans_stack << ShootEffect.new("shoot_1")
    humans_stack << ShootEffect.new("shoot_2")
    humans_stack << ShootEffect.new("shoot_3")
    humans_stack << ShootEffect.new("shoot_4")
    humans_stack << ShootEffect.new("shoot_5")

    game = ZombieGame.new(ZombieCardDealer.new.basic_zombies, humans_stack)
    game.play_zombies_turn
    game.zombies_take_cards_to_hand
    game.zombies_remove_card_to_trash("griszka_1")
    game.zombies_finish_move
    game.play_humans_turn
    game.humans_take_cards_to_hand
    assert_raises CardNotRemoved do
      game.humans_play_card(5, 1, "shoot_1")
    end

  end

  def test_humans_cant_finish_move_if_card_not_removed
    humans_stack = Stack.new
    zombie_stack = Stack.new
    griszka = ThingAppearsOnPlace.new(Zombie.new(2, "griszka"))
    zombie_stack << griszka
    zombie_stack << ThingAppearsOnPlace.new(Zombie.new(2, "griszka_1"))
    zombie_stack << ThingAppearsOnPlace.new(Zombie.new(2, "griszka_2"))
    zombie_stack << ThingAppearsOnPlace.new(Zombie.new(2, "griszka_3"))
    zombie_stack << Dawn.new

    shoot = ShootEffect.new("shoot_1")
    humans_stack << shoot
    humans_stack << ShootEffect.new("shoot_2")
    humans_stack << ShootEffect.new("shoot_3")
    humans_stack << ShootEffect.new("shoot_4")
    humans_stack << ShootEffect.new("shoot_5")

    game = ZombieGame.new(zombie_stack, humans_stack)
    game.play_zombies_turn
    game.zombies_take_cards_to_hand
    game.zombies_remove_card_to_trash("griszka_1")
    game.zombies_finish_move

    game.play_humans_turn
    game.humans_take_cards_to_hand
    assert_raises CardNotRemoved do
      game.humans_finish_move
    end
  end
end