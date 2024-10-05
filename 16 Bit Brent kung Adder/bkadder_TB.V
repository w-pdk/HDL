// Testbench for 16bit Brent-kung Adder
`include "bkadder.v"

`timescale 1 ns / 1 ns
module tb();                //declaring main module
    reg CLK, RST_N;
    reg [15:0] a, b;
    reg cin;
    wire [15:0] s;
    wire cout;

    // Declaring expected outputs
    reg [15:0] expected_sum;
    reg expected_cout;

    // Instanciate the DUT (Design Under Test) which is an instance of bkadder
    bkadder dut(
        .CLK(CLK),
        .RST_N(RST_N),          //mapping of parameters of bkadder with main module
        .a(a),
        .b(b),
        .Cin(cin),
        .sum(s),
        .carry_out(cout)
    );

    // Clock generation
    always
        #5 CLK = ~CLK;          // Toggle clock every 5 time units

    initial begin
        CLK = 1'b0;
        RST_N = 1'b0;           //initially setting clock to zero and doing reset
        #10;                    //wait time of 20ns
        RST_N = 1'b1;           // after wait time setting the reset OFF
       

        // Test Case 1
        a = 16'h3DAC; b = 16'h43CD; cin = 1'b0;
        expected_sum = 16'h81F9; expected_cout = 1'b0;
        #20;
        if (s == expected_sum && cout == expected_cout)
            $display("Correct! a=%d, b=%d, cin=%d, s=%d, cout=%d", a, b, cin, s, cout);
        else
            $display("Mistake! a=%d, b=%d, cin=%d, s=%d, cout=%d", a, b, cin, s, cout);

        // Test Case 2
        a = 16'hA843; b = 16'hCD45; cin = 1'b1;
        expected_sum = 16'h75A9; expected_cout = 1'b1;
        #20;
        if (s == expected_sum && cout == expected_cout)
            $display("Correct! a=%d, b=%d, cin=%d, s=%d, cout=%d", a, b, cin, s, cout);
        else
            $display("Mistake! a=%d, b=%d, cin=%d, s=%d, cout=%d", a, b, cin, s, cout);

        // Test Case 3
        a = 16'hC437; b = 16'hDA54; cin = 1'b0;
        expected_sum = 16'h9E8B; expected_cout = 1'b1;
        #20;
        if (s == expected_sum && cout == expected_cout)
            $display("Correct! a=%d, b=%d, cin=%d, s=%d, cout=%d", a, b, cin, s, cout);
        else
            $display("Mistake! a=%d, b=%d, cin=%d, s=%d, cout=%d", a, b, cin, s, cout);

        // Test Case 4
        a = 16'hCD56; b = 16'h5447; cin = 1'b1;
        expected_sum = 16'h21A0; expected_cout = 1'b1;
        #20;
        if (s == expected_sum && cout == expected_cout)
            $display("Correct! a=%d, b=%d, cin=%d, s=%d, cout=%d", a, b, cin, s, cout);
        else
            $display("Mistake! a=%d, b=%d, cin=%d, s=%d, cout=%d", a, b, cin, s, cout);

        // Test Case 5
        a = 16'h37FB; b = 16'h4745; cin = 1'b1;
        expected_sum = 16'h7F41; expected_cout = 1'b0;
        #20;
        if (s == expected_sum && cout == expected_cout)
            $display("Correct! a=%d, b=%d, cin=%d, s=%d, cout=%d", a, b, cin, s, cout);
        else
            $display("Mistake! a=%d, b=%d, cin=%d, s=%d, cout=%d", a, b, cin, s, cout);

        // Test Case 6
        a = 16'h5307; b = 16'hA881; cin = 1'b0;
        expected_sum = 16'hFB88; expected_cout = 1'b0;
        #20;
        if (s == expected_sum && cout == expected_cout)
            $display("Correct! a=%d, b=%d, cin=%d, s=%d, cout=%d", a, b, cin, s, cout);
        else
            $display("Mistake! a=%d, b=%d, cin=%d, s=%d, cout=%d", a, b, cin, s, cout);

        // Test Case 7
        a = 16'hA345; b = 16'hB456; cin = 1'b0;
        expected_sum = 16'h579B; expected_cout = 1'b1;
        #20;
        if (s == expected_sum && cout == expected_cout)
            $display("Correct! a=%d, b=%d, cin=%d, s=%d, cout=%d", a, b, cin, s, cout);
        else
            $display("Mistake! a=%d, b=%d, cin=%d, s=%d, cout=%d", a, b, cin, s, cout);

        // Test Case 8
        a = 16'h5667; b = 16'h452A; cin = 1'b1;
        expected_sum = 16'h9B92; expected_cout = 1'b0;
        #20;
        if (s == expected_sum && cout == expected_cout)
            $display("Correct! a=%d, b=%d, cin=%d, s=%d, cout=%d", a, b, cin, s, cout);
        else
            $display("Mistake! a=%d, b=%d, cin=%d, s=%d, cout=%d", a, b, cin, s, cout);

        // Test Case 9
        a = 16'h5749; b = 16'hB639; cin = 1'b1;
        expected_sum = 16'h0D83; expected_cout = 1'b1;
        #20;
        if (s == expected_sum && cout == expected_cout)
            $display("Correct! a=%d, b=%d, cin=%d, s=%d, cout=%d", a, b, cin, s, cout);
        else
            $display("Mistake! a=%d, b=%d, cin=%d, s=%d, cout=%d", a, b, cin, s, cout);

        // Test Case 10
        a = 16'h6578; b = 16'h638A; cin = 1'b0;
        expected_sum = 16'hC902; expected_cout = 1'b0;
        #20;
        if (s == expected_sum && cout == expected_cout)
            $display("Correct! a=%d, b=%d, cin=%d, s=%d, cout=%d", a, b, cin, s, cout);
        else
            $display("Mistake! a=%d, b=%d, cin=%d, s=%d, cout=%d", a, b, cin, s, cout); 


        #20 $finish;            // Ending the simulation at 140 ns
    end

    initial begin
        // Dumping waveforms to a file for viewing with a waveform viewer like GTKWave
        $dumpfile("waveforms.vcd");
        $dumpvars(0, dut);      // Dumping all the variables in the dut instance
    end
endmodule
