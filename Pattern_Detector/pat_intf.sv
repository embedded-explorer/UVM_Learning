//--------------------------------------------------------------------
// UVM Pattern Detector Example
// Interface
//--------------------------------------------------------------------

interface pat_intf(input logic clk, rst);

  logic serial_in;
  logic seq_found;
  
  modport dut_mp(
    input  clk      ,
    input  rst      ,
    input  serial_in,
    output seq_found
  );
  
  modport tb_mp(
    input  clk      ,
    output rst      ,
    output serial_in,
    output seq_found
  );
  
endinterface
