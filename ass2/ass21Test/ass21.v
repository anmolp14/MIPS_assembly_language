module eq4
(
  input wire clk,
  input wire[3:0] sw,
  input wire[1:0] btn,
  output wire[3:0] sum,
  output wire carry
);
reg [3:0] m , n ;
//eq1 (i0, i1, eq);

//eq1 eq-bit0-unit (.i0(a[0]), .i1(b[0]) , .eq(e0)); 
//eq1 eq-bit1-unit (.eq(e1), .i0(a[1]), .i1(b[1])) ;
always@(posedge clk)
begin
	if(btn[0])
		m <= sw;
	if(btn[1])
		n <= sw;
end
fulladder ins1 (m[0], n[0], 0, sum[0], carry1);
fulladder ins2 (m[1], n[1], carry1, sum[1], carry2);
fulladder ins3 (m[2], n[2], carry2, sum[2], carry3);
fulladder ins4 (m[3], n[3], carry3, sum[3], carry);


endmodule
