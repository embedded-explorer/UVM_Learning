//--------------------------------------------------------------------
// UVM Transaction Example
// Top Module
//--------------------------------------------------------------------
`timescale 1ns/1ps

`include "my_pkg.sv"

import uvm_pkg::*;
import my_pkg::*;

module top();

  initial begin
    run_test("my_test");
  end
  
endmodule