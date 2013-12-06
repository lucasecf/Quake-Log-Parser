require 'json'
require_relative '../modules/parse_rules'
require_relative 'kill'
require_relative 'player'

class Game
  
  attr_accessor :name, :start_time, :end_time, :players, :kills
  
  def initialize(log_string_array, name = "game_1", kills_delegate = nil)
    
    @name = name
    @kills_delegate = kills_delegate
    @players = {}
    @kills = []
    
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
          
          update_score(kill)
                    
        end
        
      end
      
    end
  end
  
  def to_hash
    { 
      :start_time => self.start_time, 
      :end_time => self.end_time, 
      :total_kills => self.total_kills, 
      :players => self.players_by_score,
      :kills => self.kills
    }
  end
  
  def to_s
    "#{self.name} : #{self.to_hash.to_json}"
  end
  
  def total_kills
    self.kills.count
  end
  
  def players_by_score
    players_array = self.players.sort_by{ |k, v| v.score}.reverse!
    players_array.map {|player_array| player_array[1] }
  end
  
  def players_by_score
    players_array = self.players.sort_by{ |k, v| v.score}.reverse!
    players_array.map {|player_array| player_array[1] }
  end
  
  
  def kills_by_reason
    
    kills_by_reason_hash = {}
    self.kills.each do |kill|
      kills_by_reason_hash[kill.death_reason] = kills_by_reason_hash[kill.death_reason].to_i + 1
    end
    
    kills_by_reason_hash.sort_by{ |k, v| v}.reverse!
    
  end
  
  def self.merge_players(games)
    
    players_hash = {}
    games.each do |game|
      
      game.players.each do |player_name, player| 
         
         if players_hash[player_name].nil?
           players_hash[player_name] = (Player.new player.name, player.kills, player.normal_deaths, player.suicides)
         else
           inserted_player = players_hash[player_name]
           inserted_player.kills += player.kills
           inserted_player.normal_deaths += player.normal_deaths
           inserted_player.suicides += player.suicides
         end
         
      end
      
    end
    
    players_array = players_hash.sort_by{ |k, v| v.score}.reverse!
    players_array.map {|player_array| player_array[1] }
  end
  
  private
  def update_score(kill)
      if kill.killer == kill.killed or kill.killer == "<world>"  #Considering that world kills is suicides
        @players[kill.killed].suicides += 1 
      else                                  #normal kill
        @players[kill.killer].kills += 1
        @players[kill.killed].normal_deaths += 1 
      end
  end
    
   
  
end