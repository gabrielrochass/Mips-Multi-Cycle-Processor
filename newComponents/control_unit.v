module control_unit(
    input wire clk,
    input wire reset,

    input wire [5:0] OPCODE,
    input wire [5:0] FUNCT,

    input wire O,
    input wire DivZero,

    // flags
    output wire PCWriteCond,
    output wire PCWrite,
    output wire MemWrite, 
    output wire IRwrite, 
    output wire RegWrite, 

    // sinais de escolha de fonte de dados
    output wire [3:0] PCSource,
    output wire [1:0] ALUSrcA,
    output wire [1:0] ALUsrcB,
    output wire [5:0] IorD,
    output wire [2:0] RegDst,
    output wire [3:0] MemtoReg,
    output wire [1:0] divCtrl,
    output wire [1:0] multCtrl,
    output wire [1:0] ShiftCtrl,
    output wire [1:0] ignore,
    output wire [1:0] BranchCtrl,

    // sinais Ctrl
    output wire [1:0] SHIPTOp3,
    output wire LoadControl,
    output wire [3:0] BranchControl,
    output wire EPCControl,
    output wire ALUOp,
    output wire [1:0] WriteDataCtrl,
    output wire WordCrackerCtrl,
    output wire [2:0] ShiftCtrl,
    output wire [2:0] EntryCtrl,
    output wire [2:0] ReduceCtrl,
    output wire HiCtrl,
    output wire LoCtrl,
    output wire ALUOutCtrl,

    // excecoes
    output wire [1:0] Ignore

    // reset
    output wire reset_out
);

// Opcodes Parameters

// R instructions
parameter R_OPCODE = 6'h0;
parameter ADD_FUNCT = 6'h20;
parameter AND_FUNCT = 6'h24;
parameter DIV_FUNCT = 6'h1a;
parameter MULT_FUNCT = 6'h18;
parameter JR_FUNCT = 6'h8;
parameter MFHI_FUNCT = 6'h10;
parameter MFLO_FUNCT = 6'h12;
parameter SLL_FUNCT = 6'h0;
parameter SLLV_FUNCT = 6'h4;
parameter SLT_FUNCT = 6'h2a;
parameter SRA_FUNCT = 6'h3;
parameter SRAV_FUNCT = 6'h7;
parameter SRL_FUNCT = 6'h2;
parameter SUB_FUNCT = 6'h22;
parameter BREAK_FUNCT = 6'hd;
parameter RTE_FUNCT = 6'h13;
parameter DIVM_FUNCT = 6'h5;


// I instructions
parameter ADDI = 6'h8;
parameter ADDIU = 6'h9;
parameter BEQ = 6'h4;
parameter BNE = 6'h5;
parameter BLE = 6'h6;
parameter BGT = 6'h7;
parameter ADDM = 6'h1;
parameter LB = 6'h20;
parameter LH = 6'h21;
parameter LUI = 6'hf;
parameter LW = 6'h23;
parameter SB = 6'h28;
parameter SH = 6'h29;
parameter SLTI = 6'ha;
parameter SW = 6'h2b;

// J instructions
parameter J = 6'h2; 
parameter JAL = 6'h3; 

// States Paramaters

parameter state_reset = 7'd0;
parameter state_fetch1 = 7'd1;
parameter state_fetch2 = 7'd2;
parameter state_decode = 7'd3;

parameter state_jump = 7'd4;
parameter state_jal1 = 7'd5;
parameter state_jal2 = 7'd6;
parameter state_jal3 = 7'd7;
parameter state_jal4 = 7'd8;
parameter wait1 = 7'd9;

parameter state_aluout = 7'd10; 

parameter state_sram1 = 7'd11; 
parameter state_sram2 = 7'd12;
parameter state_sram3 = 7'd13;
parameter state_sram4 = 7'd14;
parameter state_sram5 = 7'd15;

parameter state_RDBR = 7'd16;

parameter wait2 = 7'd17;

parameter state_break1 = 7'd18;
parameter state_break2 = 7'd19;
parameter state_break3 = 7'd20;

parameter state_rte = 7'd21;

parameter state_lui = 7'd22;

parameter state_srav = 7'd23;

parameter state_sllv = 7'd24;

parameter state_addi_slti1 = 7'd25;
parameter state_addi_slti2 = 7'd26;
parameter state_slti3 = 7'd27;
parameter state_addi_addiu3 = 7'd28;

parameter state_addiu1 = 7'd29;
parameter state_addiu2 = 7'd30;

parameter state_sra1 = 7'd31;
parameter state_sra2 = 7'd32;

parameter state_srl1 = 7'd33;
parameter state_srl2 = 7'd34;

parameter state_sll1 = 7'd35;
parameter state_sll2 = 7'd36;

parameter state_load1 = 7'd37;
parameter state_load2 = 7'd38;
parameter state_load3 = 7'd39;
parameter state_load4 = 7'd40;
parameter state_load5 = 7'd41;
parameter state_load6 = 7'd42;

parameter state_store1 = 7'd43;
parameter state_store2 = 7'd44;
parameter state_store3 = 7'd45;
parameter state_store4 = 7'd46;
parameter state_store5 = 7'd47;
parameter state_store6 = 7'd48;
parameter wait3 = 7'd49;

parameter state_ula = 7'd50;

parameter state_aluout2 = 7'd51;

parameter state_bgt = 7'd53;

parameter state_bne = 7'd54;

parameter state_ble = 7'd55;

parameter state_beq = 7'd56;

parameter state_div = 7'd57;
parameter wait4 = 7'd58;

parameter state_divzero1 = 7'd59;
parameter state_divzero2 = 7'd60;
parameter state_divzero3 = 7'd61;

parameter state_mult = 7'd62;
parameter wait5 = 7'd63;

parameter state_jr = 7'd64;
parameter wait6 = 7'd65;

parameter state_slt = 7'd66;

parameter state_add_sub_and = 7'd67;

parameter state_overflow1 = 7'd68;
parameter state_overflow2 = 7'd69;
parameter state_overflow3 = 7'd70;

parameter state_opcode_error1 = 7'd71;
parameter state_opcode_error2 = 7'd72;
parameter state_opcode_error3 = 7'd73;

parameter state_mflo = 7'd74;

parameter state_mfhi = 7'd75;

parameter state_xchg1 = 7'd76;
parameter state_xchg2 = 7'd77;
parameter state_xchg3 = 7'd78;


