module FSM(
    input wire  CLK,
    input wire  START,
    input wire  NRST,
    output reg  EN1,
    output reg  EN2,
    output reg  EN3,
    output reg  OUT_STROBE
);

//State Definition
parameter IDLE  = 2'b00;
parameter C0    = 2'b01;
parameter C1    = 2'b10;
parameter STOP  = 2'b11;
reg     [1:0]   state;

//State Transition
always @(posedge CLK or negedge NRST) begin
    if(!NRST)   state <= IDLE;
    else case(state)
        IDLE:   if(START)   state   <= C0;
                else        state   <= IDLE;
        C0:                 state   <= C1;
        C1:                 state   <= STOP;
        STOP:               state   <= STOP;
    endcase
end

//Combinational logics
always @(*) begin
    case(state)
        IDLE:   begin       EN1         <= 1'b1;
                            EN2         <= 1'b0;
                            EN3         <= 1'b0;
                            OUT_STROBE  <= 1'b0;
        end
        C0:     begin       EN1         <= 1'b1;
                            EN2         <= 1'b1;
                            EN3         <= 1'b0;
                            OUT_STROBE  <= 1'b0;
        end
        C1:     begin       EN1         <= 1'b1;
                            EN2         <= 1'b1;
                            EN3         <= 1'b1;
                            OUT_STROBE  <= 1'b0;
        end
        STOP:   begin       EN1         <= 1'b0;
                            EN2         <= 1'b0;
                            EN3         <= 1'b0;
                            OUT_STROBE  <= 1'b1;
        end
    endcase
end
endmodule