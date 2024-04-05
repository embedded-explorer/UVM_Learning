class consumer extends uvm_component;
  
  `uvm_component_utils(consumer)
  
  // Declare handle for get port
  uvm_blocking_get_port #(packet) get_port;
  
  int num_of_pkts;
  
  function new(string name = "consumer", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  // Create put implementation port
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	get_port = new("get_port", this);
  endfunction
  
  // Pull the packet from producer
  virtual task run_phase(uvm_phase phase);
    packet pkt;
	phase.raise_objection(this);
	repeat(num_of_pkts)begin
	  get_port.get(pkt);
      `uvm_info("CONS", "Packet Received", UVM_MEDIUM);
	  pkt.print(uvm_default_line_printer);
	end
	phase.drop_objection(this);
  endtask
  
endclass