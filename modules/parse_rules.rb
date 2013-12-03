module ParseRules
  
  #parse rules
  
  def self.begin_game_rule
    /InitGame/
  end
  
  def self.end_game_rule
    /--------+/
  end
  
  def self.time_rule
    /(\d)?\d:\d\d/
  end
  
  def self.kill_rule
     /Kill:/
  end
  
  def self.player_connect_rule
      /ClientUserinfoChanged: \d n\\(.*?)\\/
  end
  
  def self.player_name_rule #to be used after parsed the player connect line with the rule above
      /(?<=\\)(.*?)(?=\\)/
  end
  
  #methods to use the rules
  
  def self.begin_game_line?(log_line)
    log_line =~ ParseRules.begin_game_rule
  end
  
  def self.end_game_line?(log_line)
    log_line =~ ParseRules.end_game_rule
  end
  
  def self.kill_line?(log_line)
    log_line =~ ParseRules.kill_rule
  end
  
  def self.player_line?(log_line)
    log_line =~ ParseRules.player_connect_rule
  end
  
  
end
