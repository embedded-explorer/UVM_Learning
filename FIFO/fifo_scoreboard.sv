//--------------------------------------------------------------------
// UVM Verification Environment for Synchronous FIFO
// Scoreboard
//--------------------------------------------------------------------

class fifo_scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(fifo_scoreboard)
  
  // Item queue
  fifo_sequence_item item_queue[$];
  int ref_fifo[$];
  
  // Declare handle for analysis implementation port
  uvm_analysis_imp#(fifo_sequence_item, fifo_scoreboard) ap_export;
  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap_export = new("ap_export", this);
  endfunction
  
  // Write function
  virtual function void write(fifo_sequence_item pkt);
    item_queue.push_back(pkt);
  endfunction
  
  // Run phase
  virtual task run_phase(uvm_phase phase);
    fifo_sequence_item rx;
    int count = 0;
    int expected = 0;
    forever begin
      wait(item_queue.size() > 0);
      rx = item_queue.pop_front();
      
      if(rx.push)begin
        if(count < `DEPTH)begin
          `uvm_info(get_type_name(), $sformatf("----------:: WRITE OPERATION ::----------"), UVM_LOW)
          `uvm_info(get_type_name(), $sformatf("----------:: PASS : %0h ::----------", rx.data_i), UVM_LOW);
          count = count + 1;
          ref_fifo.push_back(rx.data_i);
        end else begin
          `uvm_info(get_type_name(), $sformatf("----------:: WRITE OPERATION ::----------"), UVM_LOW)
          `uvm_info(get_type_name(), $sformatf("----------:: FAIL : FIFO FULL ::----------"), UVM_LOW);
        end
      end
      
      if(rx.pop)begin
        expected = ref_fifo.pop_front;
        if(count > 0)begin
          `uvm_info(get_type_name(), $sformatf("----------:: READ OPERATION ::----------"), UVM_LOW)
          `uvm_info(get_type_name(), $sformatf("----------:: EXPECTED : %0h ::----------", expected), UVM_LOW);
          `uvm_info(get_type_name(), $sformatf("----------:: RECEIVED : %0h ::----------", rx.data_o), UVM_LOW);
          if(expected == rx.data_o)begin
            `uvm_info(get_type_name(), $sformatf("----------:: PASS : DATA MATCH ::----------"), UVM_LOW);
          end else begin
            `uvm_info(get_type_name(), $sformatf("----------:: FAIL : DATA MISMATCH ::----------"), UVM_LOW);
          end
          count = count - 1;
        end else begin
          `uvm_info(get_type_name(), $sformatf("----------:: READ OPERATION ::----------"), UVM_LOW)
          `uvm_info(get_type_name(), $sformatf("----------:: FAIL : FIFO EMPTY ::----------"), UVM_LOW);
        end
      end
      
    end
  endtask
  
endclass