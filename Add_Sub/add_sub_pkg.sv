//--------------------------------------------------
// Package
//--------------------------------------------------

package add_sub_pkg;
  
  `define N 4

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  `include "add_sub_seq_item.sv"
  `include "add_sub_seq.sv"
  `include "add_sub_seqr.sv"
  `include "add_sub_drv.sv"
  `include "add_sub_mon.sv"
  `include "add_sub_agnt.sv"
  `include "add_sub_scb.sv"
  `include "add_sub_env.sv"
  `include "add_sub_test.sv"

endpackage
