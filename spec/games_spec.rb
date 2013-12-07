require "spec_helper"

describe Game do
  
  let(:log_lines) { QuakeLogParser.read_file('game_logs/one_game_example.log') }
  let(:game) {Game.new log_lines}


  describe '#new' do
    
    context 'has a start and end times ' do  
      it { game.start_time.should_not be_nil }
      it { game.end_time.should_not be_nil }
    end
    
    context 'has a total of kills' do  
      it { game.total_kills.should eql 105 }
    end
    
    context 'has players' do  
      it { game.should have(4).players }
    end
    
    context 'players has a kills count' do  
      it { game.players["Dono da Bola"].kills.should eql 16}
    end
    
    context 'players has a death count' do  
      it { game.players["Dono da Bola"].normal_deaths.should eql 20}
    end
    
    context 'players has a suicide count' do  #suicide is the number of times that the player was killed by the <world>
      it { game.players["Dono da Bola"].suicides.should eql 11}
    end
    
  end
  

  describe '#kills_by_reason' do
        
      let(:kills_by_reason) { game.kills_by_reason }
      let(:test_kill) { kills_by_reason.first } #test_kill is a array of 2 elements: [DEATH_REASON, number of deaths]

      context "general ranking of kills" do
        
        it "is ordered by deaths" do  
          test_kill2 = kills_by_reason[1]
          test_kill3 = kills_by_reason[2] 
          
          test_kill[1].should > test_kill2[1]
          test_kill2[1].should > test_kill3[1]
        end
        
        it "calculates kills correctly" do   
          test_kill[0].should eql "MOD_ROCKET_SPLASH"
          test_kill[1].should eql 51
        end

      end
    
  end
  
  
  describe '.merge_players' do
    
      let(:games) { QuakeLogParser.parse_games('game_logs/two_game_example.log') }
      let(:players_ranking) { Game.merge_players(games) }
      let(:test_player) { players_ranking.first }

      context "general ranking of players" do
        
        it "is ordered by score" do  
          test_player2 = players_ranking[1]
          test_player3 = players_ranking[2] 
          
          test_player.score.should > test_player2.score
          test_player2.score.should > test_player3.score   
        end
        
        it "calculates kills correctly" do   
          test_player.kills.should eql 30
        end
        
        it "calculates deaths correctly" do   
          test_player.normal_deaths.should eql 8
        end
        
        it "calculates suicides correctly" do   
          test_player.suicides.should eql 7
        end

      end
    
  end
  
  
end
