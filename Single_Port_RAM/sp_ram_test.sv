//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Single Port RAM
// Description: Test
//--------------------------------------------------------------------

class sp_ram_test extends uvm_test;
  
  `uvm_component_utils(sp_ram_test)
  
  sp_ram_environment environment;
  
  // Constructor
  function new(string name = "sp_ram_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	environment = sp_ram_environment::type_id::create("environment", this);
  endfunction
  
  // Run phase
  virtual task run_phase(uvm_phase phase);
    sp_ram_sequence seq = sp_ram_sequence::type_id::create("seq");
    phase.raise_objection(this);
	seq.start(environment.agent.sequencer);
	phase.drop_objection(this);
  endtask
  
endclass