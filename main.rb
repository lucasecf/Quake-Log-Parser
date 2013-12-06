require 'erb'
require_relative 'quase_log_parser'


@games = QuakeLogParser.parse_games('games.log')
@ranking_players = Game.merge_players(@games)


b = binding

template_file_task1_2 = File.open("views/template_task1-2.htm.erb", 'r').read
erb_task1_2 = ERB.new(template_file_task1_2)
File.open("task1-2.htm", 'w+') { |file| file.write(erb_task1_2.result(b)) }

#plus

template_file_plus = File.open("views/template_plus.htm.erb", 'r').read
erb_plus = ERB.new(template_file_plus)
File.open("task_plus.htm", 'w+') { |file| file.write(erb_plus.result(b)) }


#printing result

#print here games beautifully

#print "OPENENING HTML FILES TO BETTER VISUALIZATION"

#TEST IN LINUX
#http://stackoverflow.com/questions/170956/how-can-i-find-which-operating-system-my-ruby-program-is-running-on

open_result = "open task_plus.htm"
output = `#{open_result}`

open_result2 = "open task1-2.htm"
output2 = `#{open_result2}`