`timescale 1 ns / 10 ps

module test_4bit;

        // Inputs
		  reg clk;
        reg [3:0] x;
        reg [1:0] check;

        // Outputs
        wire [3:0] aeqb;
		  wire carry;

        // Instantiate the Unit Under Test (UUT)
        eq4 uut (
					 .clk(clk),
                .sw(x[3:0]), 
                .btn(check[1:0]), 
                .sum(aeqb[3:0]),
					 .carry(carry)
        );

        initial begin
                // Initialize Inputs
                x = 4'b0100;
					check = 2'b01;
					clk=0;
					
					#20
					x = 4'b0101;
					check = 2'b10;
					clk=0;

                // Wait 200 ns for global reset to finish
                #200;
					 $stop;
      
                 x = 4'b0100;
					check = 2'b01;
					clk=0;
					
					#20
					x = 4'b0100;
					check = 2'b10;
					clk=0;

                #200;
                $stop;
                 x = 4'b0110;
					check = 2'b01;
					clk=0;
					
					#20
					x = 4'b0100;
					check = 2'b10;
					clk=0;

                #200;                
                $stop;
                 x = 4'b0100;
					check = 2'b01;
					clk=0;
					
					#20
					x = 4'b1100;
					check = 2'b10;
					clk=0;

                #200;
                $stop;
                 x = 4'b0110;
					check = 2'b01;
					clk=0;
					
					#20
					x = 4'b0110;
					check = 2'b10;
					clk=0;

                #200;                


                // Add stimulus here
                $stop;
        end
   always begin
		#10 clk = !clk;
	end

endmodule