class FullGame < Test::Unit::TestCase
  def test_zombie_win_by_getting_to_barricade
    dealer = ZombieCardDealer.new

    game = ZombieGame.new(dealer.zombie_stack, dealer.human_stack)

    game.zombies_take_cards_to_hand
    game.zombies_remove_card_to_trash("griszka_1")

    game.zombies_play_card_on_place("wladek_1", 0, 5)
    game.zombies_play_card_on_place("wladek_2", 2, 5)
    game.zombies_finish_move

    game.humans_take_cards_to_hand
    game.humans_remove_card_to_trash("shoot_1")
    game.humans_play_card("shoot_2", 0, 0)
    game.humans_play_card("shoot_3", 1, 0)
    game.humans_finish_move

    game.play_zombies_turn
    assert_equal(false, game.won_by_zombies?)

    #zombies now at 4
    game.zombies_take_cards_to_hand
    game.zombies_remove_card_to_trash("griszka_3")
    game.zombies_finish_move

    game.play_humans_turn
    game.humans_take_cards_to_hand
    game.humans_remove_card_to_trash("shoot_3")
    game.humans_finish_move


    game.play_zombies_turn
    assert_equal(false, game.won_by_zombies?)
    #zombies now at 3
    game.zombies_take_cards_to_hand
    game.zombies_remove_card_to_trash("griszka_4")
    game.zombies_finish_move

    game.play_humans_turn
    game.humans_take_cards_to_hand
    game.humans_remove_card_to_trash("shoot_4")
    game.humans_finish_move


    game.play_zombies_turn
    assert_equal(false, game.won_by_zombies?)
    #zombies now at 2
    game.zombies_take_cards_to_hand
    game.zombies_remove_card_to_trash("griszka_5")
    game.zombies_finish_move

    game.play_humans_turn
    game.humans_take_cards_to_hand
    game.humans_remove_card_to_trash("shoot_5")
    game.humans_finish_move


    game.play_zombies_turn
    assert_equal(false, game.won_by_zombies?)
    #zombies now at 1
    game.zombies_take_cards_to_hand
    game.zombies_remove_card_to_trash("griszka_6")
    game.zombies_finish_move

    game.play_humans_turn
    game.humans_take_cards_to_hand
    game.humans_remove_card_to_trash("shoot_6")
    game.humans_finish_move


    game.play_zombies_turn
    assert_equal(true, game.won_by_zombies?)
    #zombies now at 0
    game.zombies_take_cards_to_hand
    game.zombies_remove_card_to_trash("griszka_7")
    game.zombies_finish_move

    game.play_humans_turn
    game.humans_take_cards_to_hand
    game.humans_finish_move
  end

  def test_humans_win_because_dawn
    zombie_stack = Stack.new
    wladek_1 = ThingAppearsOnPlace.new(Zombie.new(4, "wladek"))
    wladek_2 = ThingAppearsOnPlace.new(Zombie.new(4, "wladek"))
    griszka_1 = ThingAppearsOnPlace.new(Zombie.new(2, "griszka"))
    dawn = Dawn.new
    zombie_stack << wladek_1
    zombie_stack << wladek_2
    zombie_stack << griszka_1
    zombie_stack << dawn

    humans_stack = Stack.new

    game = ZombieGame.new(zombie_stack, humans_stack)

    game.play_zombies_turn
    assert_raises ZombieLost do
      game.zombies_take_cards_to_hand
    end
  end

  def test_zombies_only_start_at_5th_row
    zombie_stack = Stack.new
    wladek = ThingAppearsOnPlace.new(Zombie.new(4, "wladek"))
    griszka = ThingAppearsOnPlace.new(Zombie.new(2, "griszka"))
    zombie_stack << wladek
    zombie_stack << ThingAppearsOnPlace.new(Zombie.new(4, "wladek"))
    zombie_stack << griszka
    zombie_stack << ThingAppearsOnPlace.new(Zombie.new(2, "griszka_1"))
    zombie_stack << Dawn.new

    humans_stack = Stack.new

    game = ZombieGame.new(zombie_stack, humans_stack)

    game.play_zombies_turn
    game.zombies_take_cards_to_hand
    game.zombies_remove_card_to_trash("griszka")
    assert_raises InvalidMove do
      game.zombies_play_card_on_place("wladek", 0, 4)
    end
  end

  def test_zombies_have_to_remove_card_to_trash
    zombie_stack = Stack.new
    wladek = ThingAppearsOnPlace.new(Zombie.new(4, "wladek"))
    zombie_stack << wladek
    zombie_stack << ThingAppearsOnPlace.new(Zombie.new(4, "wladek"))
    zombie_stack << ThingAppearsOnPlace.new(Zombie.new(2, "griszka"))
    zombie_stack << ThingAppearsOnPlace.new(Zombie.new(2, "griszka"))
    zombie_stack << ThingAppearsOnPlace.new(Zombie.new(2, "griszka"))
    zombie_stack << Dawn.new

    humans_stack = Stack.new

    game = ZombieGame.new(zombie_stack, humans_stack)

    game.play_zombies_turn
    game.zombies_take_cards_to_hand
    assert_raises CardNotRemoved do
      game.zombies_play_card_on_place("wladek", 0, 5)
    end
  end

  def test_zombies_need_to_take_cards_to_hand_before_playing

    zombie_stack = Stack.new
    wladek = ThingAppearsOnPlace.new(Zombie.new(4, "wladek"))
    zombie_stack << wladek
    zombie_stack << ThingAppearsOnPlace.new(Zombie.new(4, "wladek"))
    zombie_stack << ThingAppearsOnPlace.new(Zombie.new(2, "griszka"))
    zombie_stack << ThingAppearsOnPlace.new(Zombie.new(2, "griszka"))
    zombie_stack << ThingAppearsOnPlace.new(Zombie.new(2, "griszka"))
    zombie_stack << Dawn.new

    humans_stack = Stack.new

    game = ZombieGame.new(zombie_stack, humans_stack)

    game.play_zombies_turn
    assert_raises NoSuchCard do
      game.zombies_play_card_on_place(wladek, 0, 5)
    end
  end

  def test_zombies_need_to_take_cards_to_hand_before_removing

    zombie_stack = Stack.new
    wladek = ThingAppearsOnPlace.new(Zombie.new(4, "wladek"))
    griszka = ThingAppearsOnPlace.new(Zombie.new(2, "griszka_1"))
    zombie_stack << wladek
    zombie_stack << ThingAppearsOnPlace.new(Zombie.new(4, "wladek"))
    zombie_stack << griszka
    zombie_stack << Dawn.new

    humans_stack = Stack.new

    game = ZombieGame.new(zombie_stack, humans_stack)

    game.play_zombies_turn
    assert_raises NoSuchCard do
      game.zombies_remove_card_to_trash("griszka_1")
    end
  end

  def test_humans_need_to_remove_card_before_playing
    humans_stack = Stack.new
    zombie_stack = Stack.new
    griszka = ThingAppearsOnPlace.new(Zombie.new(2, "griszka_0"))
    zombie_stack << griszka
    zombie_stack << ThingAppearsOnPlace.new(Zombie.new(2, "griszka_1"))
    zombie_stack << ThingAppearsOnPlace.new(Zombie.new(2, "griszka_2"))
    zombie_stack << ThingAppearsOnPlace.new(Zombie.new(2, "griszka_3"))
    zombie_stack << Dawn.new

    shoot = ShootEffect.new
    humans_stack << shoot
    humans_stack << ShootEffect.new
    humans_stack << ShootEffect.new
    humans_stack << ShootEffect.new
    humans_stack << ShootEffect.new

    game = ZombieGame.new(zombie_stack, humans_stack)
    game.play_zombies_turn
    game.zombies_take_cards_to_hand
    game.zombies_remove_card_to_trash("griszka_0")
    game.zombies_finish_move

    game.play_humans_turn
    game.humans_take_cards_to_hand
    assert_raises CardNotRemoved do
      game.humans_play_card(5, 1, shoot)
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

    shoot = ShootEffect.new
    humans_stack << shoot
    humans_stack << ShootEffect.new
    humans_stack << ShootEffect.new
    humans_stack << ShootEffect.new
    humans_stack << ShootEffect.new

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

  def test_full_zombie_win_by_getting_to_barricade

    dealer = ZombieCardDealer.new
    game = ZombieGame.new(dealer.zombie_stack, dealer.human_stack)

    game.zombies_take_cards_to_hand
    game.zombies_remove_card_to_trash("griszka_1")

    game.zombies_play_card_on_place("wladek_1", 0, 5)
    game.zombies_play_card_on_place("wladek_2", 2, 5)
    game.zombies_finish_move

    game.humans_take_cards_to_hand
    game.humans_remove_card_to_trash("shoot_1")
    game.humans_play_card("shoot_2", 0, 0)
    game.humans_play_card("shoot_3", 1, 0)
    game.humans_finish_move

    game.play_zombies_turn
    assert_equal(false, game.won_by_zombies?)

    #zombies now at 4
    game.zombies_take_cards_to_hand
    game.zombies_remove_card_to_trash("griszka_3")
    game.zombies_finish_move

    game.play_humans_turn
    game.humans_take_cards_to_hand
    game.humans_remove_card_to_trash("shoot_3")
    game.humans_finish_move


    game.play_zombies_turn
    assert_equal(false, game.won_by_zombies?)
    #zombies now at 3
    game.zombies_take_cards_to_hand
    game.zombies_remove_card_to_trash("griszka_4")
    game.zombies_finish_move

    game.play_humans_turn
    game.humans_take_cards_to_hand
    game.humans_remove_card_to_trash("shoot_4")
    game.humans_finish_move


    game.play_zombies_turn
    assert_equal(false, game.won_by_zombies?)
    #zombies now at 2
    game.zombies_take_cards_to_hand
    game.zombies_remove_card_to_trash("griszka_5")
    game.zombies_finish_move

    game.play_humans_turn
    game.humans_take_cards_to_hand
    game.humans_remove_card_to_trash("shoot_5")
    game.humans_finish_move


    game.play_zombies_turn
    assert_equal(false, game.won_by_zombies?)
    #zombies now at 1
    game.zombies_take_cards_to_hand
    game.zombies_remove_card_to_trash("griszka_6")
    game.zombies_finish_move

    game.play_humans_turn
    game.humans_take_cards_to_hand
    game.humans_remove_card_to_trash("shoot_6")
    game.humans_finish_move


    game.play_zombies_turn
    assert_equal(true, game.won_by_zombies?)
    #zombies now at 0
    game.zombies_take_cards_to_hand
    game.zombies_remove_card_to_trash("griszka_7")
    game.zombies_finish_move

    game.play_humans_turn
    game.humans_take_cards_to_hand
    game.humans_finish_move
  end

end
