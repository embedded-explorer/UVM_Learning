//--------------------------------------------------------------------
// UVM Verification Environment for Synchronous FIFO
// Directed Testbench
//--------------------------------------------------------------------

`timescale 1ns/100ps

`include "fifo_intf.sv"
`include "fifo_package.sv"

  import uvm_pkg::*;
  import fifo_package::*;

module top();
  
  bit             clk   ;
  
  // Instantiate Interface
  fifo_intf #(
    .WIDTH(`WIDTH)
  )intf(
    .clk  (clk   )
  );
  
  // Instantiate DUT
  fifo#(
    .WIDTH (`WIDTH),
    .DEPTH (`DEPTH) 
  )fifo(
    .clk    (intf.clk   ),
    .rst    (intf.rst   ),
    .push   (intf.push  ),
    .data_i (intf.data_i),
    .full   (intf.full  ),
    .pop    (intf.pop   ),
    .data_o (intf.data_o),
    .empty  (intf.empty ) 
  );
  
  // Clock generation
  initial begin
    clk = 0;
	forever #5 clk = ~clk;
  end
  
  // Set Virtual Interface Handle
  initial begin
    uvm_config_db#(virtual fifo_intf)::set(uvm_root::get(), "*", "vif", intf);
  end
  
  // Run test
  initial begin
    run_test("fifo_test");
  end
  
  // Dump VCD
  initial begin
    $dumpfile("fifo_directed_tb.vcd");
	$dumpvars(0, top);
  end

endmodule