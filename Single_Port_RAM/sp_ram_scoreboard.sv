//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Single Port RAM
// Description: Scoreboard
//--------------------------------------------------------------------

class sp_ram_scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(sp_ram_scoreboard)
  
  sp_ram_sequence_item item_queue[$];
  
  bit [7:0] scb_mem [7:0];
  
  uvm_analysis_imp#(sp_ram_sequence_item, sp_ram_scoreboard) item_rcv_export;
  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	item_rcv_export = new("item_rcv_export", this);
	foreach(scb_mem[i])
	  scb_mem[i] = 8'h0;
  endfunction
  
  // Write task
  virtual function void write(sp_ram_sequence_item pkt);
    item_queue.push_back(pkt);
  endfunction
  
  // Run phase
  virtual task run_phase(uvm_phase phase);
    sp_ram_sequence_item rcv_pkt;
	
	forever begin
	  wait(item_queue.size() > 0);
	  
	  rcv_pkt = item_queue.pop_front();
	  
	  if(rcv_pkt.wr_en)begin
	    scb_mem[rcv_pkt.addr] = rcv_pkt.wr_data;
		`uvm_info(get_type_name(), $sformatf("------- :: WRITE DATA :: -------"), UVM_LOW)
		`uvm_info(get_type_name(), $sformatf("ADDR: %0h", rcv_pkt.addr), UVM_LOW)
		`uvm_info(get_type_name(), $sformatf("DATA: %0h", rcv_pkt.wr_data), UVM_LOW)
		`uvm_info(get_type_name(), "--------------------------------------", UVM_LOW)
	  end else if(rcv_pkt.rd_en)begin
	    if(scb_mem[rcv_pkt.addr] == rcv_pkt.rd_data)begin
		  `uvm_info(get_type_name(), $sformatf("------- :: READ DATA MATCH:: -------"), UVM_LOW)
		  `uvm_info(get_type_name(), $sformatf("ADDR: %0h", rcv_pkt.addr), UVM_LOW)
		  `uvm_info(get_type_name(), $sformatf("EXPECTED DATA : %0h", scb_mem[rcv_pkt.addr]), UVM_LOW)
		  `uvm_info(get_type_name(), $sformatf("ACTUAL DATA : %0h", rcv_pkt.rd_data), UVM_LOW)
		  `uvm_info(get_type_name(), "--------------------------------------", UVM_LOW)
		end else begin
		  `uvm_error(get_type_name(), $sformatf("------- :: READ DATA MISMATCH:: -------"))
		  `uvm_error(get_type_name(), $sformatf("ADDR: %0h", rcv_pkt.addr))
		  `uvm_error(get_type_name(), $sformatf("EXPECTED DATA : %0h", scb_mem[rcv_pkt.addr]))
		  `uvm_error(get_type_name(), $sformatf("ACTUAL DATA : %0h", rcv_pkt.rd_data))
		  `uvm_error(get_type_name(), "--------------------------------------")
		end
	  end
	end
	
  endtask
  
endclass