//16bit Brent-kung Adder by Utkarsh Shukla
module bkadder (
    input [15:0] a,
    input [15:0] b,           // 16-bit inputs
    input Cin,                // Carry-in
    input CLK,                // Clock signal
    input RST_N,              // Active-low reset signal
    output reg [15:0] sum,    // Registered 16-bit sum output
    output reg carry_out      // Registered carry-out output
    );

    // Internal registers for storing inputs
    reg [15:0] a_reg, b_reg;
    reg Cin_reg;
    
    // Internal signals for generate, propagate, and carry
    wire [15:0] g;
    wire [15:0] p;
    wire [15:0] carry;

    // Step 1: Generate and Propagate signals
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : gen_block
            assign g[i] = a_reg[i] & b_reg[i];  // Generate
            assign p[i] = a_reg[i] ^ b_reg[i];  // Propagate
        end
    endgenerate

    // Variables for Pre,Post and Carry generation Processing 
    wire [15:0] g_stage1, p_stage1;
    wire [15:0] g_stage2, p_stage2;
    wire [15:0] g_stage3, p_stage3;
    wire [15:0] g_stage4, p_stage4;
    wire [15:0] g_stage5, p_stage5;
    wire [15:0] g_stage6, p_stage6;
    wire [15:0] g_stage7, p_stage7; 

    // First level: CODED BY TEAM 30 processing pairs of bits (2)
    assign g_stage1[1] = g[1] | (p[1] & g[0]);
    assign p_stage1[1] = p[1] & p[0];
    assign g_stage1[3] = g[3] | (p[3] & g[2]);
    assign p_stage1[3] = p[3] & p[2];
    assign g_stage1[5] = g[5] | (p[5] & g[4]);
    assign p_stage1[5] = p[5] & p[4];
    assign g_stage1[7] = g[7] | (p[7] & g[6]);
    assign p_stage1[7] = p[7] & p[6];
    assign g_stage1[9] = g[9] | (p[9] & g[8]);
    assign p_stage1[9] = p[9] & p[8];
    assign g_stage1[11] = g[11] | (p[11] & g[10]);
    assign p_stage1[11] = p[11] & p[10];
    assign g_stage1[13] = g[13] | (p[13] & g[12]);
    assign p_stage1[13] = p[13] & p[12];
    assign g_stage1[15] = g[15] | (p[15] & g[14]);
    assign p_stage1[15] = p[15] & p[14];

    //Second level: processing groups of 4 bits (3)
    assign g_stage2[3] = g_stage1[3] | (p_stage1[3] & g_stage1[1]);
    assign p_stage2[3] = p_stage1[3] & p_stage1[1];
    assign g_stage2[7] = g_stage1[7] | (p_stage1[7] & g_stage1[5]);
    assign p_stage2[7] = p_stage1[7] & p_stage1[5];
    assign g_stage2[11] = g_stage1[11] | (p_stage1[11] & g_stage1[9]);
    assign p_stage2[11] = p_stage1[11] & p_stage1[9];
    assign g_stage2[15] = g_stage1[15] | (p_stage1[15] & g_stage1[13]);
    assign p_stage2[15] = p_stage1[15] & p_stage1[13];

    // Third level: processing groups of 8 bits (4) 
    assign g_stage3[7] = g_stage2[7] | (p_stage2[7] & g_stage2[3]);
    assign p_stage3[7] = p_stage2[7] & p_stage2[3];
    assign g_stage3[15] = g_stage2[15] | (p_stage2[15] & g_stage2[11]);
    assign p_stage3[15] = p_stage2[15] & p_stage2[11];

    // Fourth level: process the final group of 16 bits (5)
    assign g_stage4[15] = g_stage3[15] | (p_stage3[15] & g_stage3[7]);
    assign p_stage4[15] = p_stage3[15] & p_stage3[7];

    // Fifth level: process the final group of 16 bits (6)
    assign g_stage5[11] = g_stage2[11] | (p_stage2[11] & g_stage3[7]);
    assign p_stage5[11] = p_stage2[11] & p_stage3[7];	 
	 
    // Sixth  level: process the final group of 16 bits (7) 
    assign g_stage6[5] = g_stage1[5] | (p_stage1[5] & g_stage2[3]);
    assign p_stage6[5] = p_stage1[5] & p_stage2[3];
    assign g_stage6[9] = g_stage1[9] | (p_stage1[9] & g_stage3[7]);
    assign p_stage6[9] = p_stage1[9] & p_stage3[7];
    assign g_stage6[13] = g_stage1[13] | (p_stage1[13] & g_stage5[11]);
    assign p_stage6[13] = p_stage1[13] & p_stage5[11]; 

    // Seventhth level: process the final group of 16 bits (8)
    assign g_stage7[2] = g[2] | (p[2] & g_stage1[1]);
    assign p_stage7[2] = p[2] & p_stage1[1];
    assign g_stage7[4] = g[4] | (p[4] & g_stage2[3]);
    assign p_stage7[4] = p[4] & p_stage2[3];
    assign g_stage7[6] = g[6] | (p[6] & g_stage6[5]);
    assign p_stage7[6] = p[6] & p_stage6[5];
    assign g_stage7[8] = g[8] | (p[8] & g_stage3[7]);
    assign p_stage7[8] = p[8] & p_stage3[7];
    assign g_stage7[10] = g[10] | (p[10] & g_stage6[9]);
    assign p_stage7[10] = p[10] & p_stage6[9];
    assign g_stage7[12] = g[12] | (g_stage5[11] & p[12]);
    assign p_stage7[12] = p[12] & p_stage5[11];
    assign g_stage7[14] = g[14] | (p[14] & g_stage6[13]); 
    assign p_stage7[14] = p[14] & p_stage6[13];

    // Step 3: Assign carries
    assign carry[0]  = g[0] | (p[0] & Cin_reg);
    assign carry[1]  = g_stage1[1] | (p_stage1[1] & Cin_reg);
    assign carry[2]  = g[2] | (p[2] & carry[1]);
    assign carry[3]  = g_stage2[3] | (p_stage2[3] & Cin_reg);
    assign carry[4]  = g[4] | (p[4] & carry[3]);
    assign carry[5]  = g_stage6[5] | (p_stage6[5] & Cin_reg);
    assign carry[6]  = g[6] | (p[6] & carry[5]);
    assign carry[7]  = g_stage3[7] | (p_stage3[7] & Cin_reg);
    assign carry[8]  = g[8] | (p[8] & carry[7]);
    assign carry[9]  = g_stage6[9] | (p_stage6[9] & Cin_reg);
    assign carry[10] = g[10] | (p[10] & carry[9]);
    assign carry[11] = g_stage5[11] | (p_stage5[11] & Cin_reg);
    assign carry[12] = g[12] | (p[12] & carry[11]);
    assign carry[13] = g_stage6[13] | (p_stage6[13] & Cin_reg);
    assign carry[14] = g[14] | (p[14] & carry[13]);
    assign carry[15] = g_stage4[15] | (p_stage4[15] & Cin_reg);

    // Step 4: Calculate the sum bits
	 genvar j; 
	 wire [15:0] sum_wire;
     assign sum_wire[0] = p[0] ^ Cin_reg;
     
    generate
        for (j = 1; j < 16; j = j + 1) begin : gen_block2
		assign sum_wire[j] = p[j] ^ carry[j-1];
        end
    endgenerate

    // Clocking: Register the inputs and outputs
    always @(posedge CLK or negedge RST_N) begin
        if (!RST_N) begin
            // Reset the inputs and outputs
            a_reg <= 16'b0;
            b_reg <= 16'b0;
            Cin_reg <= 1'b0;
            sum <= 16'b0;
            carry_out <= 1'b0;
        end else begin
            // Register the inputs
            a_reg <= a;
            b_reg <= b;
            Cin_reg <= Cin;

            // Register the outputs
            sum <= sum_wire;
            carry_out <= carry[15];
        end
    end
endmodule