require "spec_helper"

describe QuakeLogParser do

  before :each do
    @log_lines = QuakeLogParser.read_file('spec/log_chunks_for_test/one_game_example.log')
  end
  
  describe '.read_file' do
    context 'open successfully log file' do
      it { @log_lines.should be_instance_of Array }
      it { @log_lines.should_not be_empty }
    end
  end
  

end
