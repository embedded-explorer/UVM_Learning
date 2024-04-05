//--------------------------------------------------------------------
// UVM Verification Environment for Synchronous FIFO
// Sequencer
//--------------------------------------------------------------------

class fifo_sequencer extends uvm_sequencer#(fifo_sequence_item);
  
  `uvm_component_utils(fifo_sequencer)
  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
endclass