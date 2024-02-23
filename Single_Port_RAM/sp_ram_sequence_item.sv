//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Single Port RAM
// Description: Sequence Item
//--------------------------------------------------------------------

class sp_ram_sequence_item extends uvm_sequence_item;

  // Fields within sequence item
  rand bit [2:0] addr   ;
  rand bit       wr_en  ;
  rand bit       rd_en  ;
  rand bit [7:0] wr_data;
       bit [7:0] rd_data;
  
  // Utility and Field Macros
  // Allows to use standard functions like print, copy, clone etc.
  `uvm_object_utils_begin(sp_ram_sequence_item)
    `uvm_field_int(addr   , UVM_ALL_ON)
    `uvm_field_int(wr_en  , UVM_ALL_ON)
    `uvm_field_int(rd_en  , UVM_ALL_ON)
    `uvm_field_int(wr_data, UVM_ALL_ON)
  `uvm_object_utils_end
  
  // Constructor
  function new(string name = "sp_ram_sequence_item");
    super.new(name);
  endfunction
  
  // Constraint to generate only read or write Item
  constraint wr_or_rd{ wr_en != rd_en; }
  
endclass