//--------------------------------------------------------------------
// Title      : UVM Verification Environment for Single Port RAM
// Description: Design of simple 8x8 single port RAM
//--------------------------------------------------------------------

module sp_ram(
  input              clk    , // Clock
  input              rst    , // Synchronous active high reset
  input        [2:0] addr   , // Address
  input              wr_en  , // Write enable
  input              rd_en  , // Read enable
  input        [7:0] wr_data, // Write data
  output logic [7:0] rd_data  // Read data
);
  
  // Declare 8x8 Memory
  logic [7:0] mem [7:0];
  
  always_ff @(posedge clk)begin
    if(rst)begin
	  // Initialize the contents of RAM
	  for(int i=0; i<8; i++)begin
	    mem[i] <= 8'h0;
	  end
	  rd_data <= 8'h0; // Initialize read data to 0
	end else begin
	
	  if(wr_en)begin
	  // Write data
	    mem[addr] <= wr_data;
	  end
	  
	  if(rd_en)begin
	  // Read data
	    rd_data <= mem[addr];
	  end
	  
	end
  end

endmodule