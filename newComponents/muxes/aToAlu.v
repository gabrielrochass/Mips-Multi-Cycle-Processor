// mux 2x1
module aToAlu(
    input wire [31:0] PCtoMUX,
    input wire [31:0] AtoALUSrcA,
    input wire ALUSrcA,
    output reg [31:0] ALUSrcAMUXtoALU
);

  always @(*) begin
    case (ALUSrcA)
      1'b0: ALUSrcAMUXtoALU = PCtoMUX;
      1'b1: ALUSrcAMUXtoALU = AtoALUSrcA;
      default: ALUSrcAMUXtoALU = 32'b0; // Default value
    endcase
  end
endmodule
