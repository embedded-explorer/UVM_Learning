//--------------------------------------------------------------------
// UVM Pattern Detector Example
// Driver
//--------------------------------------------------------------------

class pat_drv extends uvm_driver#(pat_seq_item);
  
  // Declare handle for virtual interface
  virtual pat_intf vif;
  
  `uvm_component_utils(pat_drv)
  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	if(!uvm_config_db#(virtual pat_intf)::get(this, "", "vif", vif))
	  `uvm_fatal("NO_VIF", {"virtual interface must be set for:", get_full_name(), ".vif"});
  endfunction
  
  // Run phase
  virtual task run_phase(uvm_phase phase);
    forever begin
      if(!vif.tb_mp.rst)begin
	    seq_item_port.get_next_item(req);
	    drive();
	    seq_item_port.item_done();
      end else begin
        @(vif.tb_mp.clk);
      end
	end
  endtask
  
  // Task to drive stimulus
  virtual task drive();
	vif.tb_mp.serial_in <= req.serial_in;
	@(vif.tb_mp.clk);
  endtask
  
endclass