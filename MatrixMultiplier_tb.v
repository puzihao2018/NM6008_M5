// -----------------------------------------------------------------------------------------
// Version | Programmer                                     | Date       | Remark   
// -----------------------------------------------------------------------------------------
// V1      | Dr Kwen-Siong Chong (kschong@ntu.edu.sg)       | 01/08/2013 | Initial version
// -----------------------------------------------------------------------------------------  
//
//  The code is a test benchmark for checking a synchronous-logic matrix multiplier
// The code is for teaching purpose in the NTU-TUM class, NM6008. 

`timescale 1ns/1ps
module MatrixMultiplier_tb;

parameter CLK_T = 50;
parameter N_TEST = 100;

reg                     err;
reg                     eval;
reg                     CLK;
reg                     NRST;
reg                     START;
reg     signed  [7:0]   A;
reg     signed  [7:0]   B;
wire    signed  [16:0]  OUT;
wire                    OUT_STROBE;

integer                 N;
reg     signed  [7:0]   A0;
reg     signed  [7:0]   A1;
reg     signed  [7:0]   B0;
reg     signed  [7:0]   B1;

integer signed          RESULT;


//Intantiation of Module
MatrixMultiplier U0(
    .CLK(CLK),
    .NRST(NRST),
    .START(START),
    .A(A),
    .B(B),
    .OUT(OUT),
    .OUT_STROBE(OUT_STROBE)
);

//CLK Generation
initial begin
    CLK = 0;
    forever #CLK_T CLK = ~CLK;
end

//Test Start
initial begin
    err = 0;
    eval = 0;


    /************************************/
    /******      Test 1           *******/
    /************************************/
    //Reset everything
    NRST = 0;
    START = 0;
    A = 0;
    B = 0;

    //Get started: Test All positive values
    #(2*CLK_T); //Delay one cycle
    NRST = 1;   //Unset RST
    A = 5;      //Sign Value A0
    B = 10;     //Sign Value B0
    //#(2*CLK_T); //After one cycle
    START = 1;  //get started
    #(2*CLK_T); //After one cycle
    A = 10;     //Sign Value A1
    B = 20;     //Sign Value B1
    #(3*CLK_T+20);//Check if the result is correct
    //Start evaluation
    eval = 1;
    if(OUT != 250) begin
        $error("Error: wrong result");
        err = 1;
    end else begin
        $display("Correct!");
        err = 0;
    end
    #(3*CLK_T-20); //After sometime
    eval = 0;

    /************************************/
    /******      Test 2           *******/
    /************************************/
    //Reset everything
    NRST = 0;
    START = 0;
    A = 0;
    B = 0;

    //Get started: Test All positive values
    #(2*CLK_T); //Delay one cycle
    NRST = 1;   //Unset RST
    A = 5;      //Sign Value A0
    B = -10;     //Sign Value B0
    //#(2*CLK_T); //After one cycle
    START = 1;  //get started
    #(2*CLK_T); //After one cycle
    A = 10;     //Sign Value A1
    B = 20;     //Sign Value B1
    #(3*CLK_T+20);//Check if the result is correct
    //Start evaluation
    eval = 1;
    if(OUT != 150) begin
        $error("Error: wrong result");
        err = 1;
    end else begin
        $display("Correct!");
        err = 0;
    end
    #(3*CLK_T-20); //After one cycle
    eval = 0;

    /************************************/
    /******      Test 3           *******/
    /************************************/
    //Reset everything
    NRST = 0;
    START = 0;
    A = 0;
    B = 0;

    //Get started: Test All positive values
    #(2*CLK_T); //Delay one cycle
    NRST = 1;   //Unset RST
    A = 5;      //Sign Value A0
    B = 10;     //Sign Value B0
    //#(2*CLK_T); //After one cycle
    START = 1;  //get started
    #(2*CLK_T); //After one cycle
    A = -10;     //Sign Value A1
    B = 20;     //Sign Value B1
    #(3*CLK_T+20);//Check if the result is correct
    //Start evaluation
    eval = 1;
    if(OUT != -150) begin
        $error("Error: wrong result");
        err = 1;
    end else begin
        $display("Correct!");
        err = 0;
    end
    #(3*CLK_T-20); //After one cycle
    eval = 0;

    /************************************/
    /******      Test 4           *******/
    /************************************/
    //Reset everything
    NRST = 0;
    START = 0;
    A = 0;
    B = 0;

    //Get started: Test All positive values
    #(2*CLK_T); //Delay one cycle
    NRST = 1;   //Unset RST
    A = 5;      //Sign Value A0
    B = -10;     //Sign Value B0
    //#(2*CLK_T); //After one cycle
    START = 1;  //get started
    #(2*CLK_T); //After one cycle
    A = -10;     //Sign Value A1
    B = 20;     //Sign Value B1
    #(3*CLK_T+20);//Check if the result is correct
    //Start evaluation
    eval = 1;
    if(OUT != -250) begin
        $error("Error: wrong result");
        err = 1;
    end else begin
        $display("Correct!");
        err = 0;
    end
    #(3*CLK_T-20); //After one cycle
    eval = 0;

    //$stop;

    //Autonomous Test with some sweeping variables
    for(N = 0; N < N_TEST; N = N + 1) begin
        A0 = $signed({$random} % 256);
        A1 = $signed({$random} % 256);
        B0 = $signed({$random} % 256);
        B1 = $signed({$random} % 256);

        RESULT = $signed(A0) * $signed(B0) + $signed(A1) * $signed(B1);

        /************************************/
        /******      Test N           *******/
        /************************************/
        //Reset everything
        NRST = 0;
        START = 0;
        A = 0;
        B = 0;

        //Get started: Test All positive values
        #(2*CLK_T); //Delay one cycle
        NRST = 1;   //Unset RST
        A = A0;      //Sign Value A0
        B = B0;     //Sign Value B0
        //#(2*CLK_T); //After one cycle
        START = 1;  //get started
        #(2*CLK_T); //After one cycle
        A = A1;     //Sign Value A1
        B = B1;     //Sign Value B1
        #(3*CLK_T+20);//Check if the result is correct
        //Start evaluation
        eval = 1;
        if(OUT != RESULT) begin
            $error("Error: wrong result");
            err = 1;
        end else begin
            $display("Test #%d is correct!",N);
            err = 0;
        end
        #(3*CLK_T-20); //After one cycle
        eval = 0;

    end
    $stop;
end


//Limit Simulation Length
initial begin
    #(10000*CLK_T);
    $stop;
end


endmodule

