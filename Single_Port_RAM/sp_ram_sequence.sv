//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Single Port RAM
// Description: Sequence
//--------------------------------------------------------------------

class sp_ram_sequence extends uvm_sequence#(sp_ram_sequence_item);

  `uvm_object_utils(sp_ram_sequence)
  
  sp_ram_sequence_item req;
  
  // Constructor
  function new(string name = "sp_ram_sequence");
    super.new(name);
  endfunction
  
  // Declare default sequencer to execute this sequence
  //`uvm_declare_p_sequencer(sp_ram_sequencer)
  
  // Task to create randomize and send item
  virtual task body();
    repeat(5)begin
	  req = sp_ram_sequence_item::type_id::create("req");
	  start_item(req);
	  assert(req.randomize());
	  finish_item(req);
	end
  endtask
  
endclass