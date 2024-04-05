//--------------------------------------------------------------------
// UVM Pattern Detector Example
// Test
//--------------------------------------------------------------------

class pat_test extends uvm_test;
  
  `uvm_component_utils(pat_test)
  
  pat_seq seq;
  pat_env env;
  
  // Constructor
  function new(string name = "test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	seq = pat_seq::type_id::create("seq");
	env = pat_env::type_id::create("env", this);
  endfunction
  
  // Run phase
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
	seq.start(env.agnt.seqr);
	phase.drop_objection(this);
  endtask
  
endclass