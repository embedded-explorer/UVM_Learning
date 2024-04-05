//--------------------------------------------------------------------
// UVM Verification Environment for Synchronous FIFO
// Sequence Item
//--------------------------------------------------------------------

class fifo_sequence_item extends uvm_sequence_item;

  // Fields
       bit            rst   ;
  rand bit            push  ;
  rand bit [`WIDTH:0] data_i;
       bit            full  ;
  rand bit            pop   ;
       bit [`WIDTH:0] data_o;
       bit            empty ;
       
  // Utility and Field Macros
  `uvm_object_utils_begin(fifo_sequence_item)
    `uvm_field_int(rst   , UVM_ALL_ON)
    `uvm_field_int(push  , UVM_ALL_ON)
    `uvm_field_int(data_i, UVM_ALL_ON)
    `uvm_field_int(full  , UVM_ALL_ON)
    `uvm_field_int(pop   , UVM_ALL_ON)
    `uvm_field_int(data_o, UVM_ALL_ON)
    `uvm_field_int(empty , UVM_ALL_ON)
  `uvm_object_utils_end
  
  // Constructor
  function new(string name = "fifo_sequence_item");
    super.new(name);
  endfunction
  
endclass