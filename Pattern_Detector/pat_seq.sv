//--------------------------------------------------------------------
// UVM Pattern Detector Example
// Sequence
//--------------------------------------------------------------------

class pat_seq extends uvm_sequence#(pat_seq_item);

  `uvm_object_utils(pat_seq)
  
  pat_seq_item req;
  
  // Constructor
  function new(string name = "pat_seq");
    super.new(name);
  endfunction
  
  // Task to create randomize and send item
  virtual task body();
    repeat(50)begin
	  req = pat_seq_item::type_id::create("req");
	  start_item(req);
	  assert(req.randomize());
	  finish_item(req);
	end
  endtask
  
endclass