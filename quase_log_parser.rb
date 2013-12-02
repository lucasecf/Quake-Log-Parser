class QuakeLogParser
  
  def self.read_file (file = 'games.log')
      lines_array = []
      file = File.open(file, 'r')
      file.each_line {|line| lines_array << line}
     
      lines_array
  end
  
  def self.parse_log(file = 'games.log')
    log_lines = QuakeLogParser.read_file('games.log')
  end
  
end