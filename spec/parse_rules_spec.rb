require "spec_helper"

describe ParseRules do
  
   
    before :all do
       @log_chunk = 
       [
          "0:00 InitGame: \\sv_floodProtect\\1\\sv_maxPing\\0\\sv_minPing\\0\\sv_maxRate\\10000\\sv_minRate\\0\\sv_hostname\\Code Miner Server\\g_gametype\\0\\sv_privateClients\\2\\sv_maxclients\16\sv_allowDownload\0\dmflags\0\fraglimit\20\timelimit\15\g_maxGameClients\0\capturelimit\8\version\ioq3 1.36 linux-x86_64 Apr 12 2009\protocol\68\mapname\q3dm17\gamename\baseq3\g_needpass\0",
          "15:00 Exit: Timelimit hit.",
          "20:34 ClientConnect: 2",
          "20:54 Kill: 1022 2 22: <world> killed Isgalamido by MOD_TRIGGER_HURT",
          "20:34 ClientUserinfoChanged: 2 n\\Isgalamido\\t\\0\\model\\xian/default\\hmodel\\xian/default\\g_redteam\\g_blueteam\\c1\4\c2\5\hc\100\w\0\l\0\tt\0\tl\0",
          "20:37 ClientUserinfoChanged: 2 n\\Isgalamido\\t\0\model\\uriel/zael\\hmodel\\uriel/zael\\g_redteam\\g_blueteam\\c1\5\c2\5\hc\100\w\0\l\0\tt\0\tl\0",
          "20:37 ClientBegin: 2",
          "20:37 ShutdownGame:",
          "20:37 ------------------------------------------------------------",
          "20:37 ------------------------------------------------------------"
         ]
    end
  
  describe 'Game Rules -' do
  
    it "parses a start game successfully" do
      ParseRules.begin_game_line?(@log_chunk.first).should be_true
    end
    
    it "parses a end game successfully" do
      ParseRules.end_game_line?(@log_chunk.last).should be_true
    end  
    
    it "parses a time successfully" do
      log_line = @log_chunk[1]
      log_line[ParseRules.time_rule].should eql "15:00" 
    end
    
  end
  
  
  describe 'Player Rules -' do
  
    it "parses a player successfully" do
      ParseRules.player_line?(@log_chunk[4]).should be_true
    end
    
  end
  
  describe 'Kill Rules -' do
    
    before :all do
       @log_line = @log_chunk[3]
       @parsed_log_line = @log_line[ParseRules.kill_rule]
    end
    
    it "parses a kill successfully" do     
      ParseRules.kill_line?(@log_line).should be_true
    end
    
    it "parses a killer successfully" do     
        @parsed_log_line[ParseRules.killer_rule].should eql "<world>"      
    end
        
    it "parses a killed player successfully" do     
        @parsed_log_line[ParseRules.killed_rule].should eql "Isgalamido" 
    end
              
    it "parses a death reason successfully" do     
        @parsed_log_line[ParseRules.death_reason_rule].should eql "MOD_TRIGGER_HURT"     
    end
    
    
    
    
  end
  
  
  

end
