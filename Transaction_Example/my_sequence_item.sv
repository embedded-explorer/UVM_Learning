//--------------------------------------------------------------------
// UVM Transaction Example
// Sequence Item
//--------------------------------------------------------------------

class my_sequence_item extends uvm_sequence_item;
  
  // Properties a, b, c, d, e, f of bit type
  rand bit  a, b, c, d, e, f;
  // Properties g, h, i, j, k of byte type
  rand byte g, h, i, j, k;
  // Enumeration list
  typedef enum bit [1:0] {w, x, y, z} my_enum_t;
  rand my_enum_t my_enum;
  
  `uvm_object_utils_begin(my_sequence_item)
    `uvm_field_int(a, UVM_DEFAULT)
    `uvm_field_int(b, UVM_DEFAULT)
    `uvm_field_int(c, UVM_DEFAULT)
    `uvm_field_int(d, UVM_DEFAULT)
    `uvm_field_int(e, UVM_DEFAULT)
    `uvm_field_int(f, UVM_DEFAULT)
    `uvm_field_int(g, UVM_DEFAULT)
    `uvm_field_int(h, UVM_DEFAULT)
    `uvm_field_int(i, UVM_NOPRINT)   // Not printable
    `uvm_field_int(j, UVM_NOCOMPARE) // Not comparable
    `uvm_field_int(k, UVM_NOCOPY)    // Not Copiable
	`uvm_field_enum(my_enum_t, my_enum, UVM_DEFAULT)
  `uvm_object_utils_end
  
  function new(string name = "my_sequence_item");
    super.new(name);
  endfunction
  
endclass
