//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Single Port RAM
// Description: Top Level Testbench
//--------------------------------------------------------------------

`timescale 1ns/1ps

`include "sp_ram_intf.sv"
`include "sp_ram_pkg.sv"

module top();
  
  import uvm_pkg::*;
  import sp_ram_pkg::*;
  
  bit clk;
  bit rst;
  
  // Generate 100MHz clock
  initial begin
    forever #5 clk = ~clk;
  end
  
  // Instantiate interface
  sp_ram_intf intf(clk, rst);
  
  // Instantiate DUT
  sp_ram sp_ram(
    .clk     (intf.clk    ),
    .rst     (intf.rst    ),
    .addr    (intf.addr   ),
    .wr_en   (intf.wr_en  ),
    .rd_en   (intf.rd_en  ),
    .wr_data (intf.wr_data),
    .rd_data (intf.rd_data)
  );
  
  // Handle Reset
  initial begin
    rst = 1;
	#5 rst = 0;
  end
  
  initial begin
	uvm_config_db#(virtual sp_ram_intf)::set(uvm_root::get(), "*", "vif", intf);
	uvm_top.finish_on_completion = 1;
	run_test("sp_ram_test");
  end
  
  // Dump signals to VCD file
  initial begin
	$dumpfile("dump.vcd");
	$dumpvars(1, sp_ram);
  end

endmodule