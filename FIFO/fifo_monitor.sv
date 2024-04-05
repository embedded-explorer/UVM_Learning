//--------------------------------------------------------------------
// UVM Verification Environment for Synchronous FIFO
// Monitor
//--------------------------------------------------------------------

class fifo_monitor extends uvm_monitor;
  
  `uvm_component_utils(fifo_monitor)
  
  // Declare handle for virtual interface
  virtual fifo_intf vif;
  
  // Declare handle for analysis port
  uvm_analysis_port#(fifo_sequence_item) ap_port;
  
  fifo_sequence_item pkt;
  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_intf)::get(this, "", "vif", vif))
      `uvm_fatal("NO_VIF", {"virtual interface not set for : ", get_full_name(), ".vif"});
    ap_port = new("ap_port", this);
  endfunction
  
  // Run phase
  virtual task run_phase(uvm_phase phase);
    pkt = fifo_sequence_item::type_id::create("pkt");
    forever begin
      sample(pkt);
      ap_port.write(pkt);
    end
  endtask
  
  // Task to sample write response
  task sample(output fifo_sequence_item pkt);
    fifo_sequence_item rx = fifo_sequence_item::type_id::create("rx");
    // Sample Inputs
    rx.rst    = vif.mon_mp.mon_cb.rst;
    rx.push   = vif.mon_mp.mon_cb.push;
    rx.data_i = vif.mon_mp.mon_cb.data_i;
    rx.pop    = vif.mon_mp.mon_cb.pop;
    rx.full   = vif.mon_mp.mon_cb.full;
    rx.empty  = vif.mon_mp.mon_cb.empty;
    @(vif.mon_mp.mon_cb);
    // Sample Outputs
    rx.data_o = vif.mon_mp.mon_cb.data_o;
    
    pkt = rx;
  endtask
  
endclass