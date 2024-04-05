//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Single Port RAM
// Description: Test
//--------------------------------------------------------------------

class sp_ram_wr_rd_test extends sp_ram_test;
  
  `uvm_component_utils(sp_ram_wr_rd_test)
  
  // Constructor
  function new(string name = "sp_ram_wr_rd_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  // Run phase
  virtual task run_phase(uvm_phase phase);
    sp_ram_wr_rd_sequence seq = sp_ram_wr_rd_sequence::type_id::create("seq");
    phase.raise_objection(this);
	seq.start(environment.agent.sequencer);
	phase.drop_objection(this);
  endtask
  
endclass