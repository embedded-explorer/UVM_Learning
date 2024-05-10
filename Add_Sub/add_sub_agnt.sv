//--------------------------------------------------
// Agent
//--------------------------------------------------

class add_sub_agnt extends uvm_agent;
  
  `uvm_component_utils(add_sub_agnt)
  
  add_sub_seqr seqr;
  add_sub_drv  drv;
  add_sub_mon  mon;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon = add_sub_mon::type_id::create("mon", this);
    if(get_is_active() == UVM_ACTIVE)begin
      drv = add_sub_drv::type_id::create("drv", this);
      seqr = add_sub_seqr::type_id::create("seqr", this);
    end
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE)begin
      drv.seq_item_port.connect(seqr.seq_item_export);
    end
  endfunction
  
endclass
