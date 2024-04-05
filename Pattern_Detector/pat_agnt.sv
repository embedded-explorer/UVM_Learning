//--------------------------------------------------------------------
// UVM Pattern Detector Example
// Agent
//--------------------------------------------------------------------

class pat_agnt extends uvm_agent;
  
  pat_drv    drv;
  pat_seqr seqr;
  
  `uvm_component_utils(pat_agnt)
  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	if(get_is_active() == UVM_ACTIVE)begin
	  drv = pat_drv::type_id::create("drv", this);
	  seqr = pat_seqr::type_id::create("seqr", this);
	end
  endfunction
  
  // Connect phase
  function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE)begin
	  drv.seq_item_port.connect(seqr.seq_item_export);
	end
  endfunction
  
endclass