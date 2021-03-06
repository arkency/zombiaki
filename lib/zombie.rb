class Zombie
  def initialize(lives=1, name="zombie", moves_back_after_shoot=true)
    @original_lives = lives
    @lives = lives
    @name  = name
    @moves_back_after_shoot = moves_back_after_shoot
  end

  def name
    @name
  end

  def one_life_left?
    @lives == 1
  end

  def hit
    @lives -= 1
  end

  def dead?
    @lives == 0
  end

  def can_move_back?
    not dead? and @moves_back_after_shoot
  end

  def lives
    @lives
  end

  def restore_health
    @lives = @original_lives
  end
end
