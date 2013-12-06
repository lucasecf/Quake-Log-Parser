REQUIREMENTS

- install rspec gem:
If not installed yet, in terminal, type "gem install rspec".


- To run all the tests written, run the follow command in terminal, inside the project root folder:
"rspec spec --format nested"

- install json gem if not installed yet. Used to print games in json format
"gem install json".

OBS: The "kills" attribute suggested in the example was changed for "score". The new "kills" attribute is an array of the "Kill" model, which holds the killer of that kill, the killed player, and the death reason.
OBS2: killed by the world means that the player get a death score, but also gets a -1 kill as a penalty

OBS3: suicides is when player kills himself, like in "Dono da Bola killed Dono da Bola by MOD_ROCKET_SPLASH" and when he gets killed by the "<world>" 