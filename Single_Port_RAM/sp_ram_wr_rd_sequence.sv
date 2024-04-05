//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Single Port RAM
// Description: Sequence
//--------------------------------------------------------------------

class sp_ram_wr_rd_sequence extends uvm_sequence#(sp_ram_sequence_item);

  `uvm_object_utils(sp_ram_wr_rd_sequence)
  
  // Constructor
  function new(string name = "sp_ram_wr_rd_sequence");
    super.new(name);
  endfunction
  
  // Task to create randomize and send item
  virtual task body();
    repeat(5)begin
	  sp_ram_sequence_item req = sp_ram_sequence_item::type_id::create("req");
	  
	  // Random Write transaction
	  start_item(req);
      assert(req.randomize() with {req.wr_en == 1'b1; req.rd_en == 1'b0;});
	  finish_item(req);
	  
	  // Read transaction from same location
      start_item(req);
	  req.wr_en = 1'b0;
	  req.rd_en = 1'b1;
	  finish_item(req);
	end
  endtask
  
endclass