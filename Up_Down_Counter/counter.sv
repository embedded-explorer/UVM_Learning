//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Up-Down Counter
// Description: Design of 4-Bit Up-Down Counter
//--------------------------------------------------------------------

module counter(
  input              clk    , // Clock
  input              rst    , // Synchronous active high reset
  input              up_down, // Up - 0, Down - 1
  output logic [3:0] count    // Count
);
  
  always_ff @(posedge clk)begin
    if(rst)begin
	  count <= 4'h0;
	end else begin
	  if(!up_down)begin
	  // Up Counting
	    count <= count + 1'b1;
	  end else begin
	  // Down Counting
	    count <= count - 1'b1;
	  end
	end
  end

endmodule