class Player
  attr_accessor :name, :kills, :deaths
  
  def initialize(name, kills = 0, deaths = 0)
    @name = name
    @kills = kills
    @deaths = deaths
  end
  
  def to_s
    "kills: #{self.kills}, deaths:#{deaths}, score: #{self.score}"
  end
  
  def score
    self.kills - self.deaths
  end
  
end