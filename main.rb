require 'erb'
require_relative 'quase_log_parser'
require_relative 'modules/os_detector'

#parsing log

file_name = nil
ARGV.each { |argument| file_name = argument }



begin
  file_name = 'game_logs/games.log' if file_name.nil?
  @games = QuakeLogParser.parse_games(file_name)
  @ranking_players = Game.merge_players(@games)
rescue 
  puts "No file with name '#{file_name}' was found"
  exit
end






#printing output in console

puts "\n\n###########################################################################"
puts "#######################  QUAKE 3 GAME LOG PARSER  #########################"
puts "###########################################################################\n\n"

puts "***********************        TASK 1 + 2         ***********************\n\n"

puts "GENERAL RANKING OF PLAYERS (ordered by score):\n"

puts JSON.pretty_generate(@ranking_players)

puts "\n\n\nGAMES (by log order):\n\n"

puts @games

puts "\n\n\n***********************           PLUS           ***********************\n\n"

puts "KILLS BY GAME REPORT (ordered by deaths):\n\n"

@games.each do |game|
   puts "#{game.name}: {" 
   puts "\t kills_by_means: {"
   game.kills_by_reason.each do |kill_array|
     puts "\t\t'#{kill_array.first}' : #{kill_array.last},"
   end
   puts "\t}"
   puts "}\n\n"
end


#writing output in .erb file, to a better visualization of the result

b = binding

template_file_task1_2 = File.open("views/template_task1-2.htm.erb", 'r').read
erb_task1_2 = ERB.new(template_file_task1_2)
File.open("task1-2.htm", 'w+') { |file| file.write(erb_task1_2.result(b)) }

template_file_plus = File.open("views/template_plus.htm.erb", 'r').read
erb_plus = ERB.new(template_file_plus)
File.open("task_plus.htm", 'w+') { |file| file.write(erb_plus.result(b)) }


if OS.mac?
  puts "\n\nOPENING GENERATED .HTML FILES IN BROWSER FOR A BETTER VISUALIZATION OF THE OUTPUT\n\n"
  open_result = "open task_plus.htm"
  output = `#{open_result}`
  
  open_result2 = "open task1-2.htm"
  output2 = `#{open_result2}`
  
elsif OS.linux?
  puts "\n\nOPENING GENERATED .HTML FILES IN BROWSER FOR A BETTER VISUALIZATION OF THE OUTPUT\n\n"
  open_result = "xdg-open task_plus.htm"
  output = `#{open_result}`

  open_result2 = "xdg-open task1-2.htm"
  output2 = `#{open_result2}`
  
else
    puts "\n\n ARE YOU USING WINDOWS?? WHAT A SHAME!!!!!! OPEN task1-2.htm AND task_plus.htm FOR A BETTER VISUALIZATION OF THE OUTPUTS!!!!!\n\n"
end


