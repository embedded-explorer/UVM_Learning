//--------------------------------------------------------------------
// UVM Pattern Detector Example
// Sequencer
//--------------------------------------------------------------------

class pat_seqr extends uvm_sequencer#(pat_seq_item);

  `uvm_component_utils(pat_seqr)
  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
endclass