//--------------------------------------------------
// Scoreboard
//--------------------------------------------------

class add_sub_scb extends uvm_scoreboard;
  
  `uvm_component_utils(add_sub_scb)

  add_sub_seq_item item_queue[$];

  uvm_analysis_imp#(add_sub_seq_item, add_sub_scb) ap_export;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap_export = new("ap_export", this);
  endfunction

  virtual function void write(add_sub_seq_item pkt);
    item_queue.push_back(pkt);
  endfunction

  virtual task run_phase(uvm_phase phase);
    add_sub_seq_item rx;
    forever begin
      wait(item_queue.size() > 0);
      rx = item_queue.pop_front();

      rx.print();
    end
  endtask
  
endclass
