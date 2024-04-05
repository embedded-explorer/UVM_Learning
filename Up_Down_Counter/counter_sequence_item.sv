//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Up-Down Counter
// Description: Sequence Item
//--------------------------------------------------------------------

class counter_sequence_item extends uvm_sequence_item;

  // Fields within sequence item
  rand bit       up_down;
       bit [3:0] count  ;
  
  // Utility and Field Macros
  // Allows to use standard functions like print, copy, clone etc.
  `uvm_object_utils_begin(counter_sequence_item)
    `uvm_field_int(up_down, UVM_ALL_ON)
    `uvm_field_int(count  , UVM_ALL_ON)
  `uvm_object_utils_end
  
  // Constructor
  function new(string name = "counter_sequence_item");
    super.new(name);
  endfunction
  
endclass