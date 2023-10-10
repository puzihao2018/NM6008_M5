// -----------------------------------------------------------------------------------------
// Version | Programmer                                     | Date       | Remark   
// -----------------------------------------------------------------------------------------
// V1      | Dr Kwen-Siong Chong (kschong@ntu.edu.sg)       | 06/08/2013 | Initial version
// -----------------------------------------------------------------------------------------  
//
// The code is a behavioural code for a synchronous-logic matrix multiplier
// The code is for teaching purpose in the NTU-TUM class, NM6008. 

module MatrixMultiplier(
input   wire            CLK,
input   wire            NRST, //Async N Reset
input   wire            START,
input   wire    [7:0]   A,
input   wire    [7:0]   B,
output  wire    [16:0]  OUT,
output  wire            OUT_STROBE
);

//Wires for intermediate connections
wire            [15:0]  C;
wire                    EN1;
wire                    EN2;
wire                    EN3;

FSM U1(
    .CLK(CLK),
    .START(START),
    .NRST(NRST),
    .EN1(EN1),
    .EN2(EN2),
    .EN3(EN3),
    .OUT_STROBE(OUT_STROBE)
);

Multiplier U2(
    .CLK(CLK),
    .NRST(NRST),
    .EN(EN1),
    .A(A),
    .B(B),
    .C(C)
);

Accumulator U3(
    .CLK(CLK),
    .NRST(NRST),
    .EN2(EN2),
    .EN3(EN3),
    .IN(C),
    .OUT(OUT)
);


endmodule


