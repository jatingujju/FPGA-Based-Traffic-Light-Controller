module debounce_sync
#(
    parameter TICKS = 3
)
(
    input wire clk,
    input wire rst,
    input wire tick,
    input wire async_in,

    output reg pulse,
    output reg level
);

reg sync1;
reg sync2;

reg [7:0] db_count;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        sync1 <= 0;
        sync2 <= 0;
    end
    else
    begin
        sync1 <= async_in;
        sync2 <= sync1;
    end
end

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        level <= 0;
        pulse <= 0;
        db_count <= 0;
    end
    else
    begin
        pulse <= 0;

        if(tick)
        begin
            if(sync2 != level)
            begin
                db_count <= db_count + 1;

                if(db_count >= TICKS)
                begin
                    level <= sync2;
                    db_count <= 0;

                    if(sync2)
                        pulse <= 1'b1;
                end
            end
            else
            begin
                db_count <= 0;
            end
        end
    end
end

endmodule