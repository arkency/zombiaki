class FullGameToTheEnd < Test::Unit::TestCase
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
    wladek_1 = ThingAppearsOnPlace.new(Zombie.new(4, "wladek_1"))
    wladek_2 = ThingAppearsOnPlace.new(Zombie.new(4, "wladek_2"))
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


