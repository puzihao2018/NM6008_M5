module Multiplier(
    input   wire            CLK,
    input   wire            NRST,
    input   wire            EN,
    input   wire    [7:0]   A,
    input   wire    [7:0]   B,    
    output  reg     [15:0]  C
);

wire [15:0] P;
assign P = $signed(A) * $signed(B);
always @(posedge CLK or negedge NRST) begin
    if(!NRST)       C   <= 0;
    else if(EN)     C   <= P;
end

endmodule