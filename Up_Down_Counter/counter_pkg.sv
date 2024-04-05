//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Up-Down Counter
// Description: Package
//--------------------------------------------------------------------

package counter_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  `include "counter_sequence_item.sv"
  `include "counter_sequence.sv"
  `include "counter_sequencer.sv"
  `include "counter_driver.sv"
  `include "counter_monitor.sv"
  `include "counter_scoreboard.sv"
  `include "counter_agent.sv"
  `include "counter_environment.sv"
  `include "counter_test.sv"
  
endpackage