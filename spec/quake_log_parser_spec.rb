require "spec_helper"

describe QuakeLogParser do

  before :each do
    @log_lines = QuakeLogParser.read_file('spec/log_chunks_for_test/three_game_example.log')
  end
  
  describe '.read_file' do
    context 'open successfully log file' do
      it { @log_lines.should be_instance_of Array }
      it { @log_lines.should_not be_empty }
    end
  end
  
  
  describe '.parse_games' do
    
    before :each do
       @games = QuakeLogParser.parse_games('spec/log_chunks_for_test/three_game_example.log')
    end
    
    context 'parsing the games' do
      it { @games.should have(3).items } #in this example, the read log has exactly 3 game logs, so the array must have 3 objects
    end
  end
  

end
