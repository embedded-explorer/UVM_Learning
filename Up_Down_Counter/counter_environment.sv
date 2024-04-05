//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Up-Down Counter
// Description: Environment
//--------------------------------------------------------------------

class counter_environment extends uvm_env;

  counter_agent agent;
  counter_scoreboard scoreboard;
  
  `uvm_component_utils(counter_environment)
  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	agent = counter_agent::type_id::create("agent", this);
	scoreboard = counter_scoreboard::type_id::create("scoreboard", this);
  endfunction
  
  // Connect phase
  function void connect_phase(uvm_phase phase);
    agent.monitor.item_rcv_port.connect(scoreboard.item_rcv_export);
  endfunction
  
endclass