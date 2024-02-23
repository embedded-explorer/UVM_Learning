//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Single Port RAM
// Description: Package
//--------------------------------------------------------------------

package sp_ram_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  
  `include "sp_ram_sequence_item.sv"
  `include "sp_ram_sequence.sv"
  `include "sp_ram_sequencer.sv"
  `include "sp_ram_driver.sv"
  `include "sp_ram_monitor.sv"
  `include "sp_ram_scoreboard.sv"
  `include "sp_ram_agent.sv"
  `include "sp_ram_environment.sv"
  `include "sp_ram_test.sv"
  
endpackage