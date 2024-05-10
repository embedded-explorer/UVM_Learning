//--------------------------------------------------
// Sequencer
//--------------------------------------------------

class add_sub_seqr extends uvm_sequencer#(add_sub_seq_item);
  
  `uvm_component_utils(add_sub_seqr)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
endclass
