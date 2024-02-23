//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Single Port RAM
// Description: Driver
//--------------------------------------------------------------------

class sp_ram_driver extends uvm_driver#(sp_ram_sequence_item);
  
  // Declare handle for virtual interface
  virtual sp_ram_intf vif;
  
  `uvm_component_utils(sp_ram_driver)
  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
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
	  seq_item_port.get_next_item(req);
	  drive();
	  seq_item_port.item_done();
	end
  endtask
  
  // Task to drive stimulus
  virtual task drive();
    vif.drv_mp.drv_cb.wr_en <= 0;
	vif.drv_mp.drv_cb.rd_en <= 0;
	
	@(vif.drv_mp.drv_cb);
	vif.drv_mp.drv_cb.addr <= req.addr;
	
	if(req.wr_en)begin
	// Write operation
	  vif.drv_mp.drv_cb.wr_en   <= req.wr_en;
	  vif.drv_mp.drv_cb.wr_data <= req.wr_data;
	  @(vif.drv_mp.drv_cb);
	end else if(req.rd_en)begin
	// Read operation
	  vif.drv_mp.drv_cb.rd_en <= req.rd_en;
	  @(vif.drv_mp.drv_cb);
	  vif.drv_mp.drv_cb.rd_en <= 0;
	  @(vif.drv_mp.drv_cb);
	  req.rd_data = vif.drv_mp.drv_cb.rd_data;
	end
	
  endtask
  
endclass