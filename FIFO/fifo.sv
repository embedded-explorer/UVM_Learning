//--------------------------------------------------------------------
// UVM Verification Environment for Synchronous FIFO
// Design
//--------------------------------------------------------------------

module fifo#(
  parameter WIDTH = 8 , // FIFO Data Width
  parameter DEPTH = 16  // FIFO Depth
)(
  input                    clk    , // Clock
  input                    rst    , // Synchronous active-high reset
  
  // Write Interface
  input                    push   , // Write to FIFO
  input        [WIDTH-1:0] data_i , // Data input
  output                   full   , // FIFO full
  
  // Read Interface
  input                    pop    , // Read from FIFO
  output logic [WIDTH-1:0] data_o , // Data output
  output                   empty    // FIFO empty
);
  
  localparam ADDR_W = $clog2(DEPTH); // Address Width
  
  logic [ADDR_W:0] wr_ptr; // Write Pointer
  logic [ADDR_W:0] rd_ptr; // Read Pointer
  logic            wr_en ; // Write Enable
  logic            rd_en ; // Read Enable
  
  // Declare FIFO Memory
  logic [ WIDTH:0] mem [DEPTH-1:0];
  
  assign wr_en = (push && ~full)   ; // Avoid writing when fifo is full
  assign rd_en = (pop  && ~empty)  ; // Avoid reading when fifo is empty
  assign empty = (wr_ptr == rd_ptr); // FIFO empty condition
  assign full  = ({~wr_ptr[ADDR_W], wr_ptr[ADDR_W-1:0]} == rd_ptr); // FIFO full condition
  
  always_ff @(posedge clk)begin
    if(rst)begin
	  // Initialize on reset
	  for(int i=0; i<DEPTH-1; i++)begin
	    mem[i] <= {WIDTH{1'b0}};
	  end
	  data_o <= {WIDTH{1'b0}} ;
	  wr_ptr <= {ADDR_W{1'b0}};
	  rd_ptr <= {ADDR_W{1'b0}};
	end else begin
	  // Write
	  if(wr_en)begin
	    mem[wr_ptr[ADDR_W-1:0]] <= data_i       ; // Write data
		wr_ptr                  <= wr_ptr + 1'b1; // Increment write pointer
	  end
	  // Read
	  if(rd_en)begin
	    data_o <= mem[rd_ptr[ADDR_W-1:0]]; // Read data
		rd_ptr <= rd_ptr + 1'b1          ; // Increment read pointer
	  end
	end
  end

endmodule