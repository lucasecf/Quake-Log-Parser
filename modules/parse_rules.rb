module ParseRules
  
  
  #game rules
  
  def self.begin_game_rule
    /InitGame/
  end
  
  def self.end_game_rule
    /--------+/
  end
  
  def self.time_rule
    /(\d)?\d:\d\d/
  end
  
  
  #kill rules
  
  def self.kill_rule
     /:\s([^:]+)\skilled\s(.*?)\sby\s[a-zA-Z_]+/
  end
  
  def self.killer_rule #to be used after parsed the kill line with the kill_rule 
     /(?<=:\s)(.*?)(?=\skilled)/
  end
  
  def self.killed_rule #to be used after parsed the kill line with the kill_rule 
     /(?<=killed\s)(.*?)(?=\sby)/
  end
  
  def self.death_reason_rule #to be used after parsed the kill line with the kill_rule 
     /(?<=by\s)(.*?)(?=$)/
  end
  

  
  #player rules
  
  def self.player_connect_rule
      /ClientUserinfoChanged: \d n\\(.*?)\\/
  end
  
  def self.player_name_rule #to be used after parsed the player connect line with the player_connect_rule
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
