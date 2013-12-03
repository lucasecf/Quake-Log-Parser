require_relative 'modules/parse_rules'
require_relative 'models/game'


class QuakeLogParser
  
  def self.read_file (file = 'games.log')
      lines_array = []
      file = File.open(file, 'r')
      file.each_line {|line| lines_array << line}
     
      lines_array
  end
  
  
  def self.parse_games(file = 'games.log')
    log_lines = QuakeLogParser.read_file(file)
    
    games = []
    begin_game_line = 0
    log_lines.each_with_index do |log_line, index|
          
      if ParseRules.begin_game_line?(log_line)
        begin_game_line = index
      elsif ParseRules.end_game_line?(log_line)
        end_game_line = index - begin_game_line.to_i + 1
        games << (Game.new log_lines[begin_game_line, end_game_line], "game_#{games.count+1}") unless begin_game_line.nil?
        begin_game_line = nil
      end          
      
    end

    #games.each {|game| puts game}

    games
    
  end
  
end