//--------------------------------------------------------------------
// UVM Pattern Detector Example
// Design
//--------------------------------------------------------------------

module pattern_detector(pat_intf intf);

  logic [3:0] shift_reg;
  
  assign intf.dut_mp.seq_found = (shift_reg == 4'b1011) ? 1'b1 : 1'b0;
  
  always_ff @(posedge intf.dut_mp.clk)begin
    if(intf.dut_mp.rst)begin
      shift_reg <= 4'b0;
    end else begin
      shift_reg <= {intf.dut_mp.serial_in, shift_reg[3:1]};
    end
  end

endmodule