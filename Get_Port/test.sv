`include "producer.sv"
`include "consumer.sv"

class test extends uvm_test;

  `uvm_component_utils(test)
  
  producer prod;
  consumer cons;
  
  function new(string name = "test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	prod = producer::type_id::create("prod", this);
	cons = consumer::type_id::create("cons", this);
	cons.num_of_pkts = 2;
  endfunction
  
  // Connect the port with export
  virtual function void connect_phase(uvm_phase phase);
    cons.get_port.connect(prod.get_imp);
  endfunction
  
endclass