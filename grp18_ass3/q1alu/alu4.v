`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:07:10 04/03/2017 
// Design Name: 
// Module Name:    alu4 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module alu4 (
	    input wire [1:0]  ALUctl,
	    input wire [3:0]  A,B,
	    output wire [3:0] ALUOut,
	    output wire       ZF,
	    output wire       CF,
	    output 	      SF
);
   reg [4:0] 		      actualOut;
   assign ALUOut = actualOut;
   assign ZF = ($signed(actualOut)==0);
   assign CF = ($signed(actualOut) > 7 || $signed(actualOut) < -8);
   assign SF = ($signed(actualOut) < 0);
   always @(ALUctl, A, B) //reevaluate if these change
     case (ALUctl)
       0: actualOut <= A & B;
       1: actualOut <= A | B;
       2: actualOut <= $signed(A) + $signed(B);
       3: actualOut <= $signed(A) - $signed(B);
       default: actualOut <= 0;
     endcase
endmodule