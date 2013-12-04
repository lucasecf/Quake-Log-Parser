class Kill
  
  attr_accessor :killer, :killed, :death_reason

   def initialize(killer, killed, death_reason)
     @killer = killer
     @killed = killed
     @death_reason = death_reason
   end
  
end