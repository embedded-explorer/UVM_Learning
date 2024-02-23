//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Single Port RAM
// Description: Environment
//--------------------------------------------------------------------

class sp_ram_environment extends uvm_env;

  sp_ram_agent agent;
  sp_ram_scoreboard scoreboard;
  
  `uvm_component_utils(sp_ram_environment)
  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	agent = sp_ram_agent::type_id::create("agent", this);
	scoreboard = sp_ram_scoreboard::type_id::create("scoreboard", this);
  endfunction
  
  // Connect phase
  function void connect_phase(uvm_phase phase);
    agent.monitor.item_rcv_port.connect(scoreboard.item_rcv_export);
  endfunction
  
endclass