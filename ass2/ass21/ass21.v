//`include "fulladder.v"

module add4( btn, clk, sw, carry, sf_e, e, rs, rw, d, c, b, a);

output reg sf_e;
output reg e;
output reg rs; 
output reg rw; 
output reg d; 
output reg c; 
output reg b; 
output reg a; 

input wire [3:0] sw;
input wire [1:0] btn;
input wire clk;
output wire carry;
        

reg [26:0] count = 0; // 27-bit count, 0-(128M-1), over 2 secs
reg [15:0] hexout;
reg [5:0] code; // 6-bits different signals to give out
reg refresh;
wire [3:0] sum;
reg [3:0] m,n;
wire carry1, carry2, carry3;
always @(posedge clk)
begin
        if (btn[0])
        begin
                 m<=sw;
        end
        else if(btn[1])
        begin
                n<=sw;
        end
end
fulladder ins1 (.a(m[0]), .b(n[0]), .carryin(0), .sum(sum[0]), .carryout(carry1));
fulladder ins2 (.a(m[1]), .b(n[1]), .carryin(carry1), .sum(sum[1]), .carryout(carry2));
fulladder ins3 (.a(m[2]), .b(n[2]), .carryin(carry2), .sum(sum[2]), .carryout(carry3));
fulladder ins4 (.a(m[3]), .b(n[3]), .carryin(carry3), .sum(sum[3]), .carryout(carry));

always @(posedge clk)
begin
count <= count+1;

        case (sum[3:0])
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

        case (count[26:21])
                0: code <= 6'h03;
                1: code <= 6'h03;
                2: code <= 6'h03;
                3: code <= 6'h02;
                4: code <= 6'h02;
                5: code <= 6'h08;
                6: code <= 6'h00;
                7: code <= 6'h06;
                8: code <= 6'h00;
                9: code <= 6'h0C;
                10: code <= 6'h00;
                11: code <= 6'h01;

                12: code <= hexout[13:8]; // Sum upper nibble 
                13: code <= hexout[5:0]; // Sum lowwe nibble
                 
                default: code <= 6'h10; 
        endcase

refresh <= count[ 20 ]; // flip rate about 25 (50MHz/2*21=2M)
sf_e <= 1; e <= refresh;
rs <= code[5]; rw <= code[4];
d <= code[3]; c <= code[2];
b <= code[1]; a <= code[0];
end

endmodule