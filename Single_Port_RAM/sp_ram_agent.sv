//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Single Port RAM
// Description: Agent
//--------------------------------------------------------------------

class sp_ram_agent extends uvm_agent;
  
  sp_ram_driver    driver;
  sp_ram_sequencer sequencer;
  sp_ram_monitor   monitor;
  
  `uvm_component_utils(sp_ram_agent)
  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	monitor = sp_ram_monitor::type_id::create("monitor", this);
	if(get_is_active() == UVM_ACTIVE)begin
	  driver = sp_ram_driver::type_id::create("driver", this);
	  sequencer = sp_ram_sequencer::type_id::create("sequencer", this);
	end
  endfunction
  
  // Connect phase
  function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE)begin
	  driver.seq_item_port.connect(sequencer.seq_item_export);
	end
  endfunction
  
endclass