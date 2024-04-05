import uvm_pkg::*;
`include "uvm_macros.svh"
`include "packet.sv"
`include "test.sv"

module testbench();
  
  initial begin
    run_test("test");
  end
  
endmodule