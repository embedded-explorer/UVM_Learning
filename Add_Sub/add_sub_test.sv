//--------------------------------------------------
// Test
//--------------------------------------------------

class add_sub_test extends uvm_test;
  
  `uvm_component_utils(add_sub_test)
  
  add_sub_seq seq;
  add_sub_env env;

  function new(string name = "add_sub_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq = add_sub_seq::type_id::create("seq");
    env = add_sub_env::type_id::create("env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(env.agnt.seqr);
    phase.drop_objection(this);
  endtask
  
endclass
