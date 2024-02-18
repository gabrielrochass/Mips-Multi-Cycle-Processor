// shiftctrlMUX
// mux 3x1
// Shift control mux - mux 3x1
module sign32_5ToReg_desloc(
    input wire [4:0] se32x5ToShift_ctrlMUX,
    input wire [4:0] IR10_6toMUXShiftCtrl,
    input wire [1:0] ShiftCtrl,
    output reg [4:0] ShiftCtrlMUXtoRD
);
    
    always @* begin
        case (ShiftCtrl)
            2'b00: ShiftCtrlMUXtoRD = se32x5ToShift_ctrlMUX;
            2'b01: ShiftCtrlMUXtoRD = 5'b10000; 
            2'b10: ShiftCtrlMUXtoRD = IR10_6toMUXShiftCtrl;
            default: ShiftCtrlMUXtoRD = 5'b0; // Valor padrão
        endcase
    end

endmodule
