module fulladder(
	input wire a,
	input wire b,
	input wire carryin,
	output wire sum,
	output wire carryout
	);

	assign sum=(a & b & carryin) | (~a & ~b & carryin) | (~a & b & ~carryin) | (a & ~b & ~carryin);
	assign carryout= (a & b & carryin) | (a & b & ~carryin) | (a & ~b & carryin) | (~a & b & carryin);
endmodule