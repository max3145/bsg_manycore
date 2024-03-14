// Code your testbench here
// or browse Examples
module tb_RF();
parameter width_p = 33;
parameter els_p = 32;
parameter addr_width_lp = 5;
  reg clk_i;
  reg reset_i;
  reg [3:0] w_v_i;
  reg [addr_width_lp-1:0] w_addr_i;
  reg [3:0][width_p-1:0] w_data_i; //width = 132
    
  reg [2:0] r_v_i;
  reg [2:0][addr_width_lp-1:0] r_addr_i;
  
  wire [2:0][width_p-1:0] r_data_o; //carries frs1,2,3
  wire [2:0][width_p-1:0] rs2_simd_data_o; //NEW OUTPUT, width 99
  
  simd_regfile rf(.clk_i(clk_i), .reset_i(reset_i), .w_v_i(w_v_i), .w_addr_i(w_addr_i), 	.w_data_i(w_data_i), .r_v_i(r_v_i), .r_addr_i(r_addr_i), .r_data_o(r_data_o), .rs2_simd_data_o(rs2_simd_data_o));

initial begin
      $dumpfile("dump.vcd");
    $dumpvars(1);
  $display("Write 2,3,4,5 at addr 0");
    clk_i = 0;
  	w_v_i=4'b0001;
    w_addr_i= 0;
    w_data_i[0]= 2;
    w_data_i[1]= 3;
    w_data_i[2]= 4;
    w_data_i[3]= 5;
    r_v_i= 3'b111;
    r_addr_i[0] = 0;
    r_addr_i[1] = 1;
    r_addr_i[2] = 2;
    #6
    display;
  
  	w_v_i=4'b1111;
    w_addr_i= 0;
    w_data_i[0]= 7;
    w_data_i[1]= 7;
    w_data_i[2]= 7;
    w_data_i[3]= 7;
    r_v_i= 3'b111;
    r_addr_i[0] = 0;
    r_addr_i[1] = 0;
    r_addr_i[2] = 2;
    #16
    display;
    w_v_i=4'b0010;
    w_addr_i= 30;
    w_data_i[0]= 4;
    w_data_i[1]= 7;
    w_data_i[2]= 7;
    w_data_i[3]= 7;
    r_v_i= 3'b111;
    r_addr_i[0] = 0;
    r_addr_i[1] = 0;
    r_addr_i[2] = 31;
    #26
    display;
  
end    

  always #5 clk_i = ~clk_i;
  
  task display;
    #1 $display("rs1_data_o:%0h, rs2_data_o:%0h, rs3_data_o:%0h, simd[0]:0%h, simd[1]:0%h, simd[2]:0%h",r_data_o[0], r_data_o[1], r_data_o[2], rs2_simd_data_o[0], rs2_simd_data_o[1], rs2_simd_data_o[2]);
  endtask
  
endmodule
