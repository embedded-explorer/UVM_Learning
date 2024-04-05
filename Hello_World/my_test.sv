//--------------------------------------------------------------------
// UVM Hello World Example
// Test Case
//--------------------------------------------------------------------

class my_test extends uvm_test;

  `uvm_component_utils(my_test)
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  task run_phase(uvm_phase phase);
  begin
    phase.raise_objection(this);
    #10;
    `uvm_info(" ", "Hello World!", UVM_MEDIUM)
    phase.drop_objection(this);
  end
  endtask
  
endclass
