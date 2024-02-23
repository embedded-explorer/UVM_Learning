//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Single Port RAM
// Description: Interface
//--------------------------------------------------------------------

interface sp_ram_intf(
  input clk,
  input rst
);

  logic [2:0] addr   ;
  logic       wr_en  ;
  logic       rd_en  ;
  logic [7:0] wr_data;
  logic [7:0] rd_data;
  
  // Clocking block for driver
  clocking drv_cb @(posedge clk);
    default input #1 output #1;
	
	input  rd_data;
	output addr   ;
	output wr_en  ;
	output rd_en  ;
	output wr_data;
  endclocking
  
  // Clocking block for monitor
  clocking mon_cb @(posedge clk);
    default input #1 output #1;
	
	input  addr   ;
	input  wr_en  ;
	input  rd_en  ;
	input  wr_data;
	input  rd_data;
  endclocking
  
  // Modport for driver
  modport drv_mp(
    clocking drv_cb,
	input    clk,
	input    rst
  );
  
  // Modport for monitor
  modport mon_mp(
    clocking mon_cb,
	input    clk,
	input    rst
  );
  
endinterface