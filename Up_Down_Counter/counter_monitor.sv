//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Up-Down Counter
// Description: Monitor
//--------------------------------------------------------------------

class counter_monitor extends uvm_monitor;
  
  // Declare handle for virtual interface
  virtual counter_intf vif;
  
  uvm_analysis_port #(counter_sequence_item) item_rcv_port;
  
  counter_sequence_item item_rcv;
  
  `uvm_component_utils(counter_monitor)
  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
	item_rcv = new();
	item_rcv_port = new("item_rcv_port", this);
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
	    item_rcv.up_down = vif.mon_mp.mon_cb.up_down;
        @(vif.mon_mp.mon_cb);
	    item_rcv.count = vif.mon_mp.mon_cb.count;
	    item_rcv_port.write(item_rcv);
      end else begin
        @(vif.mon_mp.mon_cb);
      end
	end
  endtask
  
endclass