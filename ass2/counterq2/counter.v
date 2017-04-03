
`timescale 1ns / 1ps

module counter(
        input clk,
        input wire[3:0] init,
        input wire set,
        input wire reset,
        output reg[3:0] count
);
reg [25:0] count1 = 50_000_000;
initial count <=0;
always @(posedge reset or posedge set or posedge clk)
begin
        if (reset)
        begin
                count <= 4'b0000;
        end
        else if(set)
        begin
                count <= init;
        end
        else
        begin
        if (count1==0) begin
                count <= count+1;
                count1 <= 50_000_000;
        end
        else
        begin
                count1 <= count1 - 1;
        end
        end
end

endmodule