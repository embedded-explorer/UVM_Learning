//--------------------------------------------------
// Interface
//--------------------------------------------------

`define N 4

interface add_sub_intf();
  
  logic [`N-1:0] a_i;
  logic [`N-1:0] b_i;
  logic          c_i;
  logic [`N-1:0] s_o;
  logic          c_o;
  
  modport tb_mp(
    output a_i,
    output b_i,
    output c_i,
    input  s_o,
    input  c_o
  );
  
  initial begin
    $display("[Interface] \t: 231038001 HRISHIKESH");
  end

endinterface

