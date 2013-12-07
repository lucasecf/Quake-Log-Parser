require "spec_helper"

describe QuakeLogParser do

  let(:log_lines) { QuakeLogParser.read_file('game_logs/three_game_example.log') }
  
  describe '.read_file' do
    context 'open successfully log file' do
      it { log_lines.should be_instance_of Array }
      it { log_lines.should_not be_empty }
    end
  end
  
  
  describe '.parse_games' do
    let(:games) { QuakeLogParser.parse_games('game_logs/three_game_example.log') }
    
    context 'parsing the games' do
      it { games.should have(3).items } #in this example, the read log has exactly 3 game logs, so the array must have 3 objects
    end
  end
  

end
