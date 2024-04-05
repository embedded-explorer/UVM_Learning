//--------------------------------------------------------------------
// UVM Verification Environment for Synchronous FIFO
// Sequence
//--------------------------------------------------------------------

class fifo_sequence extends uvm_sequence#(fifo_sequence_item);
  
  `uvm_object_utils(fifo_sequence)
  
  fifo_sequence_item pkt;
  
  // Constructor
  function new(string name = "fifo_sequence");
    super.new(name);
  endfunction
  
  // Task to create randomize and send item
  virtual task body();
    pkt        = fifo_sequence_item::type_id::create("pkt");
    // Apply Reset
    repeat (2) apply_reset();
    // Write until FIFO gets full
    repeat (`DEPTH) write();
    // Write to Full FIFO
    write();
    // Read until FIFO gets empty
    repeat (`DEPTH) read();
    // Read from empty FIFO
    read();
  endtask
  
  // Task to apply reset
  task apply_reset();
    start_item(pkt);
    pkt.rst    = 1;
    pkt.push   = 0;
    pkt.pop    = 0;
    pkt.data_i = 0;
    finish_item(pkt);
  endtask
  
  // Task to write
  task write();
    start_item(pkt);
    pkt.randomize()with{pkt.push == 1; pkt.pop == 0;};
    pkt.rst    = 0;
    finish_item(pkt);
  endtask
  
  // Task to read
  task read();
    start_item(pkt);
    pkt.randomize()with{pkt.pop == 1; pkt.push == 0;};
    pkt.rst    = 0;
    finish_item(pkt);
  endtask
  
endclass