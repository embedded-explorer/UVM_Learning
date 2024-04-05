//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Up-Down Counter
// Description: Test
//--------------------------------------------------------------------

class counter_test extends uvm_test;
  
  `uvm_component_utils(counter_test)
  
  counter_sequence seq;
  counter_environment environment;
  
  // Constructor
  function new(string name = "test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	seq = counter_sequence::type_id::create("seq");
	environment = counter_environment::type_id::create("environment", this);
  endfunction
  
  // Run phase
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
	seq.start(environment.agent.sequencer);
	phase.drop_objection(this);
	
	// Set drain time
	phase.phase_done.set_drain_time(this, 50);
  endtask
  
endclass