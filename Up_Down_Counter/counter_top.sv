//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Up-Down Counter
// Description: Top Level Testbench
//--------------------------------------------------------------------

`timescale 1ns/1ps

`include "counter_intf.sv"
`include "counter_pkg.sv"

module top();
  
  import uvm_pkg::*;
  import counter_pkg::*;
  
  bit clk;
  bit rst;
  
  // Generate 100MHz clock
  initial begin
    forever #5 clk = ~clk;
  end
  
  // Instantiate interface
  counter_intf intf(clk, rst);
  
  // Instantiate DUT
  counter counter(
    .clk     (intf.clk    ),
    .rst     (intf.rst    ),
    .up_down (intf.up_down),
    .count   (intf.count  )
  );
  
  // Handle Reset
  initial begin
    rst = 1;
    repeat(2)
    @(posedge clk);
	rst <= 0;
  end
  
  initial begin
	uvm_config_db#(virtual counter_intf)::set(uvm_root::get(), "*", "vif", intf);
	uvm_top.finish_on_completion = 1;
	run_test("counter_test");
  end
  
  // Dump signals to VCD file
  initial begin
	$dumpfile("dump.vcd");
	$dumpvars(1, counter);
  end

endmodule