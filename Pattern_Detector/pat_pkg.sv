//--------------------------------------------------------------------
// UVM Pattern Detector Example
// Package
//--------------------------------------------------------------------

package pat_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  `include "pat_seq_item.sv"
  `include "pat_seq.sv"
  `include "pat_seqr.sv"
  `include "pat_drv.sv"
  `include "pat_agnt.sv"
  `include "pat_env.sv"
  `include "pat_test.sv"

endpackage
