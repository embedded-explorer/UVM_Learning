//--------------------------------------------------------------------
// UVM Pattern Detector Example
// Environment
//--------------------------------------------------------------------

class pat_env extends uvm_env;

  pat_agnt agnt;
  
  `uvm_component_utils(pat_env)
  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	agnt = pat_agnt::type_id::create("agnt", this);
  endfunction
  
endclass