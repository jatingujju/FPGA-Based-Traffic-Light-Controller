module timer
(
    input wire clk,
    input wire rst,
    input wire tick,
    input wire start,
    input wire [15:0] duration,
    output reg done
);

reg [15:0] count;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        count <= 0;
        done <= 0;
    end
    else
    begin
        done <= 0;

        if(start)
        begin
            count <= duration;
        end
        else if(tick && count != 0)
        begin
            count <= count - 1'b1;

            if(count == 1)
                done <= 1'b1;
        end
    end
end

endmodule