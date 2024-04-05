//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Up-Down Counter
// Description: Scoreboard
//--------------------------------------------------------------------

class counter_scoreboard extends uvm_scoreboard;
  
  counter_sequence_item item_queue[$];
  
  bit [3:0] scb_count;
  
  uvm_analysis_imp#(counter_sequence_item, counter_scoreboard) item_rcv_export;
  
  `uvm_component_utils(counter_scoreboard)
  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_rcv_export = new("item_rcv_export", this);
    scb_count = 4'h0;
  endfunction
  
  // Write task
  virtual function void write(counter_sequence_item pkt);
    item_queue.push_back(pkt);
  endfunction
  
  // Run phase
  virtual task run_phase(uvm_phase phase);
    counter_sequence_item rcv_pkt;
    
    forever begin
      wait(item_queue.size() > 0);
      
      rcv_pkt = item_queue.pop_front();
      
      if(scb_count == rcv_pkt.count)begin
        `uvm_info(get_type_name(), $sformatf("------- :: COUNT MATCH :: -------"), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("EXPECTED COUNT : %0h", scb_count), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("ACTUAL COUNT : %0h", rcv_pkt.count), UVM_LOW)
        `uvm_info(get_type_name(), "--------------------------------------", UVM_LOW)
      end else begin
        `uvm_error(get_type_name(), $sformatf("------- :: COUNT MISMATCH :: -------"))
        `uvm_error(get_type_name(), $sformatf("EXPECTED COUNT : %0h", scb_count))
        `uvm_error(get_type_name(), $sformatf("ACTUAL COUNT : %0h", rcv_pkt.count))
        `uvm_error(get_type_name(), "--------------------------------------")
      end
      
      if(!rcv_pkt.up_down)begin
        scb_count = scb_count + 1'b1;
      end else begin
        scb_count = scb_count - 1'b1;
      end
      
    end
    
  endtask
  
endclass