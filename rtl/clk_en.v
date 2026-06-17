module clk_en
#(
    parameter CLK_HZ  = 50_000_000,
    parameter TICK_HZ = 1
)
(
    input  wire clk,
    input  wire rst,
    output reg  tick
);

localparam DIV = CLK_HZ / TICK_HZ;

reg [31:0] counter;

always @(posedge clk or posedge rst)
begin
    if (rst)
    begin
        counter <= 0;
        tick <= 1'b0;
    end
    else
    begin
        tick <= 1'b0;

        if(counter == DIV-1)
        begin
            counter <= 0;
            tick <= 1'b1;
        end
        else
        begin
            counter <= counter + 1'b1;
        end
    end
end

endmodule