//--------------------------------------------------
// Design
//--------------------------------------------------

module add_sub#(
  parameter N = 4
)(
  input  [N-1:0] a_i,
  input  [N-1:0] b_i,
  input          c_i,
  output [N-1:0] s_o,
  output         c_o
);

  logic [N:0] c;
  
  assign c[0] = c_i;
  assign c_o  = c[N];
  
  genvar i;
  generate
    for(i=0; i<N; i=i+1)begin
      full_adder fa(
        .a_i (a_i[i]      ),
        .b_i (b_i[i] ^ c_i),
        .c_i (c[i]        ),
        .s_o (s_o[i]      ),
        .c_o (c[i+1]      ) 
      );
    end
  endgenerate
  
  initial begin
    $display("[Design] \t: 231038001 HRISHIKESH");
  end

endmodule

module full_adder(
  input  a_i,
  input  b_i,
  input  c_i,
  output s_o,
  output c_o
);
  
  assign s_o = a_i ^ b_i ^ c_i;
  assign c_o = (a_i & b_i) | (b_i & c_i) | (a_i & c_i);
  
endmodule
