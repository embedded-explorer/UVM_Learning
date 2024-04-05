//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Single Port RAM
// Description: Monitor
//--------------------------------------------------------------------

class sp_ram_monitor extends uvm_monitor;
  
  `uvm_component_utils(sp_ram_monitor)
  
  // Declare handle for virtual interface
  virtual sp_ram_intf vif;
  
  uvm_analysis_port #(sp_ram_sequence_item) item_rcv_port;
  
  sp_ram_sequence_item item_rcv;
  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
	item_rcv = new();
	item_rcv_port = new("item_rcv_port", this);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	if(!uvm_config_db#(virtual sp_ram_intf)::get(this, "", "vif", vif))
	  `uvm_fatal("NO_VIF", {"virtual interface must be set for:", get_full_name(), ".vif"});
  endfunction
  
  // Run phase
  virtual task run_phase(uvm_phase phase);
    forever begin
	  @(vif.mon_mp.mon_cb);
	  wait(vif.mon_mp.mon_cb.wr_en || vif.mon_mp.mon_cb.rd_en);
	  item_rcv.addr = vif.mon_mp.mon_cb.addr;
	  
	  if(vif.mon_cb.wr_en)begin
	    item_rcv.wr_en   = vif.mon_mp.mon_cb.wr_en;
	    item_rcv.wr_data = vif.mon_mp.mon_cb.wr_data;
	    item_rcv.rd_en   = 0;
		@(vif.mon_mp.mon_cb);
	  end else if(vif.mon_mp.mon_cb.rd_en)begin
	    item_rcv.rd_en   = vif.mon_mp.mon_cb.rd_en;
		item_rcv.wr_en   = 0;
		@(vif.mon_mp.mon_cb);
		@(vif.mon_mp.mon_cb);
		item_rcv.rd_data = vif.mon_mp.mon_cb.rd_data;
	  end
	  
	  item_rcv_port.write(item_rcv);
	end
  endtask
  
endclass