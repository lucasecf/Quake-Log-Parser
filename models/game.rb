require 'json'
require_relative '../modules/parse_rules'
require_relative 'kill'
require_relative 'player'

class Game
  
  attr_accessor :name, :start_time, :end_time, :players, :kills, :score, :kills_delegate
  
  def initialize(log_string_array, name = "game_1", kills_delegate = nil)
    
    @name = name
    @kills_delegate = kills_delegate
    @players = {}
    @kills = []
    @score = {}
    
    if log_string_array.count > 1
      
      @start_time = log_string_array.first[ParseRules.time_rule]
      @end_time = log_string_array.last[ParseRules.time_rule]
      
      log_string_array.each do |log_line|
        
        if ParseRules.player_line?(log_line)
          
          player_name = log_line[ParseRules.player_connect_rule][ParseRules.player_name_rule]
          @players[player_name] = (Player.new player_name) unless @players[player_name]
          
        elsif ParseRules.kill_line?(log_line)
          
          parsed_line = log_line[ParseRules.kill_rule]
          kill = Kill.new parsed_line[ParseRules.killer_rule], parsed_line[ParseRules.killed_rule], parsed_line[ParseRules.death_reason_rule]
          @kills << kill
          

          #todo: remove kill when killed by world
          #@players[kill.killer].kills += 1
          #@players[kill.killed].deaths += 1 
          
        end
        
      end
      
    end
  end
  
  def to_hash
    hash = {}
    self.instance_variables.each {|var| hash[var.to_s.delete("@")] = self.instance_variable_get(var) }
    hash.delete("name")
    hash.delete("kills_delegate")
    hash
  end
  
  def to_s
    "#{self.name} : #{self.to_hash.to_json}"
  end
  
  def total_kills
    self.kills.count
  end
  
  # def players_names
  #      @players.map{|player| player.name}
  #   end
  
  def increment_score(player)
    self.score[player] = self.score[player].to_i + 1
  end
  
  def decrement_score(player)
    self.score[player] = self.score[player].to_i - 1
  end
  
end