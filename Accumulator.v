module Accumulator(
    input wire          CLK,
    input wire          NRST,
    input wire          EN2,
    input wire          EN3,
    input wire  [15:0]  IN,
    output reg  [16:0]  OUT
);

    reg [16:0]  FF;
    wire [16:0] D;

always @(posedge CLK or negedge NRST) begin
    if(!NRST) begin
        FF  <= 0;
        OUT <= 0;
    end else begin
        if(EN2) FF <= D;
        if(EN3) OUT <= D;
    end
end

//Combinational logic
assign D = $signed({IN[15],IN}) + $signed(FF);

endmodule
