//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Up-Down Counter
// Description: Sequencer
//--------------------------------------------------------------------

class counter_sequencer extends uvm_sequencer#(counter_sequence_item);

  `uvm_component_utils(counter_sequencer)
  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
endclass