//--------------------------------------------------
// Sequence
//--------------------------------------------------

class add_sub_seq extends uvm_sequence#(add_sub_seq_item);
  
  `uvm_object_utils(add_sub_seq)
  
  function new(string name = "add_sub_seq");
    super.new(name);
  endfunction

  virtual task body();
    add_sub_seq_item req = add_sub_seq_item::type_id::create("req");
    repeat(10)begin
      start_item(req);
      void'(req.randomize());
      finish_item(req);
    end
  endtask
  
endclass
