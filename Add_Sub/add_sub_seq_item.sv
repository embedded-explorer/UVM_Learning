//--------------------------------------------------
// Sequence Item
//--------------------------------------------------

//`define N 4

class add_sub_seq_item extends uvm_sequence_item;
  
  rand bit [`N-1:0] a_i;
  rand bit [`N-1:0] b_i;
  rand bit          c_i;
       bit [`N-1:0] s_o;
       bit          c_o;
       
  `uvm_object_utils_begin(add_sub_seq_item)
    `uvm_field_int(a_i, UVM_DEFAULT)
    `uvm_field_int(b_i, UVM_DEFAULT)
    `uvm_field_int(c_i, UVM_DEFAULT)
    `uvm_field_int(s_o, UVM_DEFAULT)
    `uvm_field_int(c_o, UVM_DEFAULT)
  `uvm_object_utils_end
  
  function new(string name = "add_sub_seq_item");
    super.new(name);
  endfunction
  
endclass
