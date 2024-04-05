class producer extends uvm_component;
  
  `uvm_component_utils(producer)
  
  // Declare handle for get implementation port
  uvm_blocking_get_imp #(packet, producer) get_imp;
  
  function new(string name = "producer", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  // Create get implementation port
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	get_imp = new("get_imp", this);
  endfunction
  
  // Define get method
  virtual task get(output packet pkt);
    pkt = new();
	assert(pkt.randomize());
	`uvm_info("PROS", "Packet Sent", UVM_MEDIUM);
	pkt.print(uvm_default_line_printer);
  endtask
  
endclass