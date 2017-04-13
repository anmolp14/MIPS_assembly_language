`timescale 1ns/10ps

module alu4_test();
   wire CF, SF, ZF;
   reg [3:0] in1, in2;
   wire [3:0] out;
   reg [1:0]  ctl;

   alu4 uut(ctl, in1, in2, out, ZF, CF, SF);
   initial begin
      ctl = 0;
      in1 = 4'b0011;
      in2 = 4'b1101;
      #200;
      $display("Result Carry Sign Zero: %d %d %d %d", out, CF, SF, ZF);
      ctl = 1;
      in1 = 4'b0001;
      in2 = 4'b1110;
      #200;
      $display("Result Carry Sign Zero: %d %d %d %d", out, CF, SF, ZF);
      ctl = 2;
      in1 = $signed(3);
      in2 = $signed(7);
      #200;
      $display("Result Carry Sign Zero: %d %d %d %d", out[2:0], CF, SF, ZF);
      ctl = 3;
      in1 = $signed(2);
      in2 = $signed(5);
      #200;
      $display("Result Carry Sign Zero: %d %d %d %d", out[2:0], CF, SF, ZF);
      $stop;
   end // initial begin
endmodule