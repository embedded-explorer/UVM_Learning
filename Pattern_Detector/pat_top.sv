//--------------------------------------------------------------------
// UVM Pattern Detector Example
// Simple Testbench
//--------------------------------------------------------------------

`timescale 1ns/1ps

`include "pat_intf.sv"
`include "pat_pkg.sv"

module pat_top();
  
  import uvm_pkg::*;
  import pat_pkg::*;

  logic clk      ;
  logic rst      ;
  
  pat_intf intf(clk, rst);
  
  pattern_detector pattern_detector(intf);
  
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  initial begin
    rst = 1;
	@(posedge clk);
	rst <= 0;
  end
  
  initial begin
    uvm_config_db#(virtual pat_intf)::set(null, "*", "vif", intf);
    run_test("pat_test");
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, pat_top);
  end

endmodule
