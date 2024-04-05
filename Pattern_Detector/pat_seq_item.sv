//--------------------------------------------------------------------
// UVM Pattern Detector Example
// Sequence Item
//--------------------------------------------------------------------

class pat_seq_item extends uvm_sequence_item;
  
  rand bit serial_in;
  
  `uvm_object_utils_begin(pat_seq_item)
    `uvm_field_int(serial_in, UVM_DEFAULT)
  `uvm_object_utils_end
  
  function new(string name = "pat_seq_item");
    super.new(name);
  endfunction
  
  // 70% 1's and remaining 0's
  constraint confine {serial_in dist{1 := 70, 0 := 30};}

endclass
