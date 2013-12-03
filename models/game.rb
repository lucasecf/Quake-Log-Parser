require 'json'
require_relative '../modules/parse_rules'

class Game
  
  attr_accessor :name, :start_time, :end_time, :total_kills, :players, :kills
  
  def initialize(log_string_array, name = "game_1")
    
    @name = name
    
    if log_string_array.count > 1
      @start_time = log_string_array.first[ParseRules.time_rule]
      @end_time = log_string_array.last[ParseRules.time_rule]
      
      @total_kills = 0
      @players = []
      @kills = []
      
      log_string_array.each do |log_line|
        
        if ParseRules.player_line?(log_line)
          player_name = log_line[ParseRules.player_connect_rule][ParseRules.player_name_rule]
          @players << player_name unless @players.include? player_name
        elsif ParseRules.kill_line?(log_line)
          @total_kills += 1
        end
        
      end
      
      
    end
  end
  
  def to_hash
    hash = {}
    self.instance_variables.each {|var| hash[var.to_s.delete("@")] = self.instance_variable_get(var) }
    hash.delete("name")
    hash
  end
  
  def to_s
    "#{self.name} : #{self.to_hash.to_json}"
  end
  
end