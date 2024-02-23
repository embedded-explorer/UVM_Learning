//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Single Port RAM
// Description: Sequencer
//--------------------------------------------------------------------

class sp_ram_sequencer extends uvm_sequencer#(sp_ram_sequence_item);

  `uvm_component_utils(sp_ram_sequencer)
  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
endclass