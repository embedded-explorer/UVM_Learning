//--------------------------------------------------------------------
// UVM Transaction Example
// Test
//--------------------------------------------------------------------

class my_test extends uvm_test;
  
  `uvm_component_utils(my_test)
  
  function new(string name = "my_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    my_sequence_item seq_1 = my_sequence_item::type_id::create("seq_1");
    my_sequence_item seq_2 = my_sequence_item::type_id::create("seq_2");
    my_sequence_item seq_3 = my_sequence_item::type_id::create("seq_3");
    my_sequence_item seq_4;
	
	// Randomize and print sequence 1
	seq_1.randomize();
	seq_1.print();
	
	// Copy seq_1 to seq_2 and print
	seq_2.copy(seq_1);
	seq_2.print();
	
	// Randomize seq_3
	seq_3.randomize();
    seq_3.print();
	
	// Test Compare method
    seq_3.compare(seq_1);
    
    seq_2.compare(seq_1);
	
	// Test clone method
	$cast(seq_4, seq_1.clone());
	seq_4.print();
    
    seq_4.compare(seq_1);
	
  endtask
  
endclass
