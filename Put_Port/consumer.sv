class consumer extends uvm_component;
  
  `uvm_component_utils(consumer)
  
  // Declare handle for put implementation port
  uvm_blocking_put_imp #(packet, consumer) put_imp;
  
  function new(string name = "consumer", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  // Create put implementation port
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	put_imp = new("put_imp", this);
  endfunction
  
  // Define put method
  virtual task put(packet pkt);
    `uvm_info("CONS", "Packet Received", UVM_MEDIUM);
	pkt.print(uvm_default_line_printer);
  endtask
  
endclass