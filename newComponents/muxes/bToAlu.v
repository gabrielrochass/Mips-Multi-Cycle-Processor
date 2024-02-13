// mux 4x1 = mux ALUSrcB
module mux4x1(
    input [31:0] BtoALUSrcBMUX,
    input [31:0] reg4,
    input [31:0] SE16_32toALUsrcB,
    input [31:0] SLtoAluSrcBMUX,
    input [1:0] ALUSrcB,
    output reg [31:0] ALUSrcBMUXtoALU
);

  always @(*) begin
    case (ALUSrcB)
      3'b00: ALUSrcBMUXtoALU = BtoALUSrcBMUX;
      3'b01: ALUSrcBMUXtoALU = reg4;
      3'b10: ALUSrcBMUXtoALU = SLtoAluSrcBMUX;
      3'b11: ALUSrcBMUXtoALU = SE16_32toALUsrcB;
      default: ALUSrcBMUXtoALU = 32'b0; // Default value
    endcase
  end
endmodule
