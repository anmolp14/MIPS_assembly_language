`timescale 1ns/10ps
module regdisp (
		input 	       pb1, pb2, pb3, pb4, pb5, clk,
		input wire [3:0]  sw,
		output wire [3:0] out1, out2
		);
wire [3:0] 			       result1, result2;
assign out1 = result1;
assign out2 = result2;
reg [3:0] 			       rr1 = 4'b0000;
reg [3:0] 			       rr2 = 4'b0000;
reg [3:0] 			       wr = 4'b0000;
reg [3:0] 			       wdata = 4'b0000;
regfile a_unit(clk, pb5, rr1, rr2, wr, wdata, result1, result2);

always@(posedge clk) begin
	if (pb1 == 1)
		rr1 = sw;
	if (pb2 == 1)
		rr2 = sw;
	if (pb3 == 1)
		wr = sw;
	if (pb4 == 1)
		wdata = sw;
end // always @ (posedge clk)

endmodule