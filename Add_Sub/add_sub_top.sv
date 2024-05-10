//--------------------------------------------------
// Top
//--------------------------------------------------

`timescale 1ns/100ps

//`define N 4

`include "add_sub.sv"
`include "add_sub_intf.sv"
`include "add_sub_pkg.sv"

import uvm_pkg::*;
import add_sub_pkg::*;

module top();
  
  add_sub_intf intf();
  
  add_sub #(
    .N   (`N  )
  )rca(
    .a_i   (intf.a_i  ),
    .b_i   (intf.b_i  ),
    .c_i   (intf.c_i  ),
    .s_o   (intf.s_o  ),
    .c_o   (intf.c_o  )
  );

  initial begin
    uvm_config_db#(virtual add_sub_intf)::set(uvm_root::get(), "*", "vif", intf);
  end

  initial begin
    run_test("add_sub_test");
  end

  initial begin
    $dumpfile("top.vcd");
	$dumpvars(0, top);
  end

endmodule
