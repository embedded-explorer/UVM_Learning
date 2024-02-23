//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Single Port RAM
// Description: Top Level Testbench
//--------------------------------------------------------------------

`include "sp_ram_intf.sv"

module top();

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
  
  initial begin
    rst = 1;
	
	// Initialize the signals
	intf.drv_mp.drv_cb.addr    <= 0;
	intf.drv_mp.drv_cb.wr_en   <= 0;
	intf.drv_mp.drv_cb.rd_en   <= 0;
	intf.drv_mp.drv_cb.wr_data <= 0;
	
	// Remove reset
	#5 rst = 0;
	
	// Perform write
	@(intf.drv_cb);
	intf.drv_mp.drv_cb.wr_en   <= 1;
	intf.drv_mp.drv_cb.addr    <= 3;
	intf.drv_mp.drv_cb.wr_data <= 37;
	@(posedge clk);
	intf.drv_mp.drv_cb.wr_en   <= 0;
	intf.drv_mp.drv_cb.addr    <= 0;
	
	// Perform read
	@(posedge clk);
	intf.drv_mp.drv_cb.rd_en   <= 1;
	intf.drv_mp.drv_cb.addr    <= 3;
	intf.drv_mp.drv_cb.addr    <= 3;
	@(posedge clk);
	intf.drv_mp.drv_cb.wr_en   <= 0;
	intf.drv_mp.drv_cb.addr    <= 0;
	@(posedge clk);
	
	$finish;
  end
  
  // Dump signals to VCD file
  initial begin
	$dumpfile("dump.vcd");
	$dumpvars(1, sp_ram);
  end

endmodule