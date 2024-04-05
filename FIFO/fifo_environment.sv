//--------------------------------------------------------------------
// UVM Verification Environment for Synchronous FIFO
// Environment
//--------------------------------------------------------------------

class fifo_environment extends uvm_env;
  
  `uvm_component_utils(fifo_environment)
  
  fifo_agent agent;
  fifo_scoreboard scoreboard;
  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = fifo_agent::type_id::create("agent", this);
    scoreboard = fifo_scoreboard::type_id::create("scoreboard", this);
  endfunction
  
  // Connect phase
  function void connect_phase(uvm_phase phase);
    agent.monitor.ap_port.connect(scoreboard.ap_export);
  endfunction
  
endclass
  