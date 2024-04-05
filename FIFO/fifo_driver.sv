//--------------------------------------------------------------------
// UVM Verification Environment for Synchronous FIFO
// Driver
//--------------------------------------------------------------------

class fifo_driver extends uvm_driver#(fifo_sequence_item);
  
  `uvm_component_utils(fifo_driver)
  
  // Declare handle for virtual interface
  virtual fifo_intf vif;
  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_intf)::get(this, "", "vif", vif))
      `uvm_fatal("NO_VIF", {"virtual interface not set for : ", get_full_name(), ".vif"});
  endfunction
  
  // Run phase
  task run_phase(uvm_phase phase);
    fifo_sequence_item pkt;
    pkt = fifo_sequence_item::type_id::create("pkt");
    forever begin
      seq_item_port.get_next_item(pkt);
      drive(pkt);
      seq_item_port.item_done();
    end
  endtask
  
  // Task to drive stimulus
  task drive(fifo_sequence_item pkt);
    vif.drv_mp.drv_cb.rst    <= pkt.rst;
    vif.drv_mp.drv_cb.push   <= pkt.push;
    vif.drv_mp.drv_cb.data_i <= pkt.data_i;
    vif.drv_mp.drv_cb.pop    <= pkt.pop;
    @(vif.drv_mp.drv_cb);
    
    if(pkt.rst)begin
      vif.drv_mp.drv_cb.rst <= 0;
    end
    
    if(pkt.push)begin
      vif.drv_mp.drv_cb.push   <= 0;
    end 
    
    if(pkt.pop) begin
      vif.drv_mp.drv_cb.pop   <= 0;
    end
    
  endtask
  
endclass