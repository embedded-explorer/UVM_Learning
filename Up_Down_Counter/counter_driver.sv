//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Up-Down Counter
// Description: Driver
//--------------------------------------------------------------------

class counter_driver extends uvm_driver#(counter_sequence_item);
  
  // Declare handle for virtual interface
  virtual counter_intf vif;
  
  `uvm_component_utils(counter_driver)
  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	if(!uvm_config_db#(virtual counter_intf)::get(this, "", "vif", vif))
	  `uvm_fatal("NO_VIF", {"virtual interface must be set for:", get_full_name(), ".vif"});
  endfunction
  
  // Run phase
  virtual task run_phase(uvm_phase phase);
    forever begin
      if(!vif.drv_mp.rst)begin
	    seq_item_port.get_next_item(req);
	    drive();
	    seq_item_port.item_done();
      end else begin
        @(vif.drv_mp.drv_cb);
      end
	end
  endtask
  
  // Task to drive stimulus
  virtual task drive();
	vif.drv_mp.drv_cb.up_down <= req.up_down;
	@(vif.drv_mp.drv_cb);
  endtask
  
endclass