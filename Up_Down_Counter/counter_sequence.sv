//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Up-Down Counter
// Description: Sequence
//--------------------------------------------------------------------

class counter_sequence extends uvm_sequence#(counter_sequence_item);

  `uvm_object_utils(counter_sequence)
  
  counter_sequence_item req;
  
  // Constructor
  function new(string name = "counter_sequence");
    super.new(name);
  endfunction
  
  // Task to create randomize and send item
  virtual task body();
    repeat(10)begin
	  req = counter_sequence_item::type_id::create("req");
	  start_item(req);
	  assert(req.randomize());
	  finish_item(req);
	end
  endtask
  
endclass