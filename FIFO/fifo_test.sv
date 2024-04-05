//--------------------------------------------------------------------
// UVM Verification Environment for Synchronous FIFO
// Test
//--------------------------------------------------------------------

class fifo_test extends uvm_test;
  
  `uvm_component_utils(fifo_test)
  
  fifo_sequence seq;
  fifo_environment env;
  
  // Constructor
  function new(string name = "fifo_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq = fifo_sequence::type_id::create("seq");
    env = fifo_environment::type_id::create("env", this);
  endfunction
  
  // Run phase
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(env.agent.sequencer);
    phase.drop_objection(this);
    
    // Set drain time
    phase.phase_done.set_drain_time(this, 50);
  endtask
  
endclass