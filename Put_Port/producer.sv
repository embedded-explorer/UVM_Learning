`include "packet.sv"

class producer extends uvm_component;
  
  `uvm_component_utils(producer)
  
  // Declare handle for put port
  uvm_blocking_put_port #(packet) put_port;
  
  int num_of_pkts;
  
  function new(string name = "producer", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  // Create put port
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	put_port = new("put_port", this);
  endfunction
  
  // Randomize and push the packet using put method
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
	repeat(num_of_pkts)begin
	  packet pkt = packet::type_id::create("pkt");
	  assert(pkt.randomize());
	  `uvm_info("PROD", "Packet Sent", UVM_MEDIUM);
	  pkt.print(uvm_default_line_printer);
	  put_port.put(pkt);
	end
	phase.drop_objection(this);
  endtask
  
endclass