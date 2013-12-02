require "spec_helper"

describe Game do

   before :each do
      @log_lines = QuakeLogParser.read_file('spec/log_chunks_for_test/one_game_example.log')
      @game = Game.new @log_lines
   end
    
   describe '#new' do
      context 'has a start time' do
         it { @game.start_time.should_not be_nil }
      end
    end
  

end
