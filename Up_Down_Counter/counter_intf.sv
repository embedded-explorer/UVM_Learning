//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Up-Down Counter
// Description: Interface
//--------------------------------------------------------------------

interface counter_intf(
  input clk,
  input rst
);

  logic       up_down;
  logic [3:0] count  ;
  
  // Clocking block for driver
  clocking drv_cb @(posedge clk);
    default input #1 output #1;
	
	input  count  ;
	output up_down;
  endclocking
  
  // Clocking block for monitor
  clocking mon_cb @(posedge clk);
    default input #1 output #1;
	
	input  up_down;
	input  count  ;
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