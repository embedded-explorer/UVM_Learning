//--------------------------------------------------
// Driver
//--------------------------------------------------

class add_sub_drv extends uvm_driver#(add_sub_seq_item);
  
  `uvm_component_utils(add_sub_drv)

  virtual add_sub_intf vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual add_sub_intf)::get(this, "", "vif", vif))
      `uvm_fatal("NO_VIF", {"virtual interface not set for : ", get_full_name(), ".vif"});
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive(req);
      seq_item_port.item_done();
    end
  endtask
  
  virtual task drive(add_sub_seq_item req);
    vif.tb_mp.a_i = req.a_i;
    vif.tb_mp.b_i = req.b_i;
    vif.tb_mp.c_i = req.c_i;
    #10;
  endtask
  
endclass
