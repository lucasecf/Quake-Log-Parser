Quake Game log parser
===========

## About

This project was made using just pure Ruby, without any external dependencies. The project development was totally   behaviour-driven (BDD), using the ruby rspec gem to write the specs. The Tasks 1, 2 and also the Plus were accomplished successfully.


## Developer notes

Some adjustments were made in the Task 1 expected result example, in order to better fit in the modeling used, which had more informations than required extracted from the log. The program keeps track of not only the kills of each player, but he's kills, deaths, suicides and final score. It's important to highlight what each of this attributes means:

* Kills is the absolute count of kills of the player, without any penalty;
* Normal Deaths is the absolute amount of times a player dies by the hands of another player;
* Suicides is the number of times a player is killed by the world, like this:
```  
12:15 Kill: 1022 4 19: <world> killed Zeh by MOD_FALLING
```

   or when he kills himself, like this:
```  
12:13 Kill: 3 3 7: Dono da Bola killed Dono da Bola by MOD_ROCKET_SPLASH
```
* And finally, <b>Score</b> is calculated by the kills of the player, minus his suicides (penalty).


So, the output of each game is something like this:
``` 
game_15 : {
  "start_time": "11:03",
  "end_time": "16:53",
  "total_kills": 122,
  "players": ["Isgalamido", "Oootsimo", "Chessus", "Zeh", "Dono da Bola", "Assasinu Credi", "Mal"],
  "kills": [
    "Isgalamido -> kills: 25, normal_deaths:9, suicides:3, score: 22",
    "Oootsimo -> kills: 12, normal_deaths:8, suicides:3, score: 9",
    "Chessus -> kills: 10, normal_deaths:11, suicides:3, score: 7",
    "Zeh -> kills: 11, normal_deaths:13, suicides:8, score: 3",
    "Dono da Bola -> kills: 8, normal_deaths:17, suicides:8, score: 0",
    "Assasinu Credi -> kills: 8, normal_deaths:10, suicides:9, score: -1",
    "Mal -> kills: 3, normal_deaths:9, suicides:11, score: -8"
  ]
}
``` 

## Parse rules

One of the biggest concerns through the development of this project was the maintenance of the parser. And if somehow the log structure changes just a little bit?

The basic of parsing is made using Regular Expressions. A module class was created to gather and centralize all the expressions used to recognize every single event in the log, like a kill event, player connect event, game begin event, etc. So, if a adaptation in the log structure was required, the maintainer will only have to modify this file, without the need of digging further in the parsing logic of another classes.


* This file with the Parse Rules can be found in `project_folder/modules/parse_rules.rb`

## Running the parser

### Tests
To run all the tests of the project, just type the follow command, inside the project folder:
```  
rspec spec
```
You can also user the `--format nested` to see more informations about the tests

Obs: type `gem install rspec` if you don't have it installed


### Output
Simply type the command below in console, inside the project folder:
```  
ruby main.rb
```

This will write the output of the parser inside the console, and will also open a web-browser with a `html` output, in order to provide a better visualization. This html file is generated through a `.erb` template.
