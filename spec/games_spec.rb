require "spec_helper"

describe Game do
  
  before :each do
    @log_lines = QuakeLogParser.read_file('spec/log_chunks_for_test/one_game_example.log')
    @game = Game.new @log_lines
  end
        
  describe '#new' do
    
    context 'has a start and end times ' do  
      it { @game.start_time.should_not be_nil }
      it { @game.end_time.should_not be_nil }
    end
    
    context 'has a total of kills' do  
      it { @game.total_kills.should eql 105 }
    end
    
    context 'has players' do  
      it { @game.should have(4).players }
    end
    
  end
  
end
