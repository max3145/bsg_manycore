/**
 *    s_regfile_synth.sv
 *
 *    SIMD synthesized register file
 *
 *    @author max
 */

`include "bsg_defines.sv"

module simd_regfile
  #(`BSG_INV_PARAM(width_p)
    , `BSG_INV_PARAM(els_p)

    , localparam addr_width_lp=`BSG_SAFE_CLOG2(els_p)
  )

module simd_regfile
  (
    input clk_i
    , input reset_i

    , input [3:0] w_v_i //one hot write enable
    , input [addr_width_lp-1:0] w_addr_i
    , input [3:0][width_p-1:0] w_data_i //width = 132
    
    , input [2:0] r_v_i
    , input [2:0][addr_width_lp-1:0] r_addr_i
    , output logic [width_p-1:0] rs1_data_o //carries frs1
    , output logic [width_p-1:0] rs2_data_o //carries frs2_scalar
    , output logic [width_p-1:0] rs3_data_o //carries frs3
    , output logic [2:0][width_p-1:0] rs2_simd_data_o //NEW OUTPUT, width 99
  );

  wire unused = reset_i;
  
  logic [2:0][addr_width_lp-1:0] r_addr_r;


  always_ff @ (posedge clk_i)
    for (integer i = 0; i < 3; i++)
      if (r_v_i[i]) r_addr_r[i] <= r_addr_i[i];


  logic [3:0][width_p-1:0] mem_r [(els_p>>2)-1:0];
   
  assign rs1_data_o = mem_r[r_addr_r[0][4:2]][r_addr_r[0][1:0]];
  assign rs2_data_o = mem_r[r_addr_r[1][4:2]][r_addr_r[1][1:0]]; 
  assign rs3_data_o = mem_r[r_addr_r[2][4:2]][r_addr_r[2][1:0]];
  
  for (genvar i = 0; i < 3; i++)
     assign rs2_simd_data_o[i] = mem_r[r_addr_r[1][4:2]][i+1]; 
    
  always_ff @ (posedge clk_i) begin
    for (integer i = 0; i < 4; i++) begin
      if (w_v_i[i]) begin
        mem_r[w_addr_i[4:2]][i] <= w_data_i[i];
      end
    end
  end

endmodule

`BSG_ABSTRACT_MODULE(SIMD_regfile_synth)

