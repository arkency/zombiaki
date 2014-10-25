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
