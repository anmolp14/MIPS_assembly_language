`timescale 1ns/10ps

module processordisp (
			  output reg 	   sf_e, e, rs, rw, d, c, b, a,
			  input 	   pb1, pb2, pb3, pb4, clk,
			  input wire [3:0] sw,
			  output wire 	   SF, CF, ZF, invalid_op
			  );
   reg [26:0] 				   count;
   reg [5:0] 				   code;
   reg 					   refresh;
   reg [3:0] 				   inp1 = 4'b0000;
   reg [3:0] 				   inp2 = 4'b0000;
   reg [2:0] 				   opcode = 3'b111;
   wire 				   sign, zero, carry;
   wire [3:0] 				   result;
	wire [3:0]              r2;
   assign SF = sign;
   assign ZF = zero;
   assign CF = carry;
	reg [15:0] hexout;
	assign r2 = sign == 1 ? ~result + 1 : result[2:0];
   processor uut(.opcode(opcode),
		 .inp1(inp1), .inp2(inp2),
		 .clk(clk), .reg_w_enable(pb4),
		 .SF(sign), .ZF(zero), .CF(carry),
		 .result(result),
		 .invalid_op(invalid_op));
   always@(posedge clk) begin
      if (pb1 == 1)
        inp1 = sw;
      if (pb2 == 1)
	inp2 = sw;
      if (pb3 == 1)
	opcode = sw[2:0];

      count <= count + 1;

	begin
	     if (opcode == 3'b010 || opcode == 3'b011)
	       begin
		  case (r2)
		    0: hexout = 16'h2320;
                1: hexout = 16'h2321;
                2: hexout = 16'h2322;
                3: hexout = 16'h2323;
                4: hexout = 16'h2324;
                5: hexout = 16'h2325;
                6: hexout = 16'h2326;
                7: hexout = 16'h2327;
                8: hexout = 16'h2328;
                9: hexout = 16'h2329;
                10: hexout = 16'h2421;
                11: hexout = 16'h2422;
                12: hexout = 16'h2423;
                13: hexout = 16'h2424;
                14:hexout = 16'h2425;
                15:hexout = 16'h2426;
                default: hexout = 0;
		  endcase
	       end
	     else
	       begin
		  case (result)
		    0: hexout = 16'h2320;
                1: hexout = 16'h2321;
                2: hexout = 16'h2322;
                3: hexout = 16'h2323;
                4: hexout = 16'h2324;
                5: hexout = 16'h2325;
                6: hexout = 16'h2326;
                7: hexout = 16'h2327;
                8: hexout = 16'h2328;
                9: hexout = 16'h2329;
                10: hexout = 16'h2421;
                11: hexout = 16'h2422;
                12: hexout = 16'h2423;
                13: hexout = 16'h2424;
                14:hexout = 16'h2425;
                15:hexout = 16'h2426;
                default: hexout = 0;
		  endcase
	       end
	  end

      case (count [26:21]) // as top 6 bits change
	0: code <= 6'h03; // power-on init sequence
	1: code <= 6'h03; // this is needed at least once
	2: code <= 6'h03; // when LCD's powered on
	3: code <= 6'h02; // it flickers existing char dislay
	4: code <= 6'h02; // Function Set, upper nibble 0010
	5: code <= 6'h08; // lower nibble 1000 (10xx)
	6: code <= 6'h00; // see table, upper nibble 0000, then lower nibble:
	7: code <= 6'h06; // 0110: Incr, Shift disabled
	8: code <= 6'h00; // Display On/Off, upper nibble 0000
	9: code <= 6'h0C; // lower nibble 1100 (1 D C B)
	10: code <= 6'h00; // Clear Display, 00 and upper nibble 0000
	11: code <= 6'h01; // then 00 and lower nibble 0001
	12: code <= hexout[13:8];
	13:code <= hexout[5:0];
	14: code <= 6'h21; // Table 5-3, Read Busy Flag and Address
	// send 01 BF (Busy Flag) x x x, then 01xxxx
	// idling

	default: code <= 6'h10; // the restun-used time
      endcase

      refresh <= count[ 20 ]; // flip rate about 25 (50MHz/2*21=2M)
      sf_e <= 1; e <= refresh;
      rs <= code[5]; rw <= code[4];
      d <= code[3]; c <= code[2];
      b <= code[1]; a <= code[0];
   end
endmodule