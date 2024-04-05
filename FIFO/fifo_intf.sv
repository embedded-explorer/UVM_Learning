//--------------------------------------------------------------------
// UVM Verification Environment for Synchronous FIFO
// Interface
//--------------------------------------------------------------------

interface fifo_intf#(
  parameter WIDTH = 8
)(
  input clk
);
  
  logic             rst   ; // Reset
  logic             push  ; // Write to FIFO
  logic [WIDTH-1:0] data_i; // Data input
  logic             full  ; // FIFO full
  logic             pop   ; // Read from FIFO
  logic [WIDTH-1:0] data_o; // Data output
  logic             empty ; // FIFO empty
  
  // Driver Clocking Block
  clocking drv_cb @(posedge clk);
    default input #1 output #1;
	
    input  rst   ;
	input  full  ;
	input  empty ;
    output rst   ;
	output push  ;
	output data_i;
	output pop   ;
  endclocking
  
  // Monitor Clocking Block
  clocking mon_cb @(posedge clk);
    default input #1 output #1;
	
    input rst   ;
    input push  ;
    input data_i;
    input full  ;
    input pop   ;
    input data_o;
    input empty ;
  endclocking
  
  // Driver Modport
  modport drv_mp(
    clocking drv_cb,
	input    clk
  );
  
  // Monitor Modport
  modport mon_mp(
    clocking mon_cb,
	input    clk
  );

endinterface