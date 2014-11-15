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

  def test_humans_need_to_remove_card_before_playing
    dealer = ZombieCardDealer.new
    game = ZombieGame.new(dealer.basic_zombies, dealer.basic_humans)
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
    dealer = ZombieCardDealer.new
    game = ZombieGame.new(dealer.basic_zombies, dealer.basic_humans)
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
