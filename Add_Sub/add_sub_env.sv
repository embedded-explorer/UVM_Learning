//--------------------------------------------------
// Environment
//--------------------------------------------------

class add_sub_env extends uvm_env;
  
  `uvm_component_utils(add_sub_env)
  
  add_sub_agnt agnt;
  add_sub_scb  scb;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agnt = add_sub_agnt::type_id::create("agnt", this);
    scb = add_sub_scb::type_id::create("scb", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    agnt.mon.ap_port.connect(scb.ap_export);
  endfunction
  
endclass
  
