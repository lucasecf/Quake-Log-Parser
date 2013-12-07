class Player
  attr_accessor :name, :kills, :normal_deaths, :suicides
  
  def initialize(name, kills = 0, normal_deaths = 0, suicides = 0)
    @name = name
    @kills = kills
    @normal_deaths = normal_deaths
    @suicides = suicides
  end
  
  def to_s
    "#{self.name} -> kills: #{self.kills}, normal_deaths:#{self.normal_deaths}, suicides:#{self.suicides}, score: #{self.score}"
  end
  
  def score
    self.kills - self.suicides
  end
  
end