//--------------------------------------------------
// Monitor
//--------------------------------------------------

class add_sub_mon extends uvm_monitor;
  
  `uvm_component_utils(add_sub_mon)

  virtual add_sub_intf vif;

  uvm_analysis_port#(add_sub_seq_item) ap_port;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual add_sub_intf)::get(this, "", "vif", vif))
      `uvm_fatal("NO_VIF", {"virtual interface not set for : ", get_full_name(), ".vif"});
    ap_port = new("ap_port", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    add_sub_seq_item pkt = add_sub_seq_item::type_id::create("pkt");
    forever begin
      sample(pkt);
      ap_port.write(pkt);
    end
  endtask
  
  // Task to sample write response
  virtual task sample(output add_sub_seq_item pkt);
    add_sub_seq_item rx = add_sub_seq_item::type_id::create("rx");
    // Sample Inputs
    #5;
    rx.a_i = vif.tb_mp.a_i;
    rx.b_i = vif.tb_mp.b_i;
    rx.c_i = vif.tb_mp.c_i;
    rx.s_o = vif.tb_mp.s_o;
    rx.c_o = vif.tb_mp.c_o;
    #5;
    pkt = rx;
  endtask
  
endclass
