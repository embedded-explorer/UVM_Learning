//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Single Port RAM
// Description: Environment
//--------------------------------------------------------------------

class sp_ram_environment extends uvm_env;

  sp_ram_agent agent;
  
  `uvm_component_utils(sp_ram_environment)
  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	agent = sp_ram_agent::type_id::create("agent", this);
  endfunction
  
endclass