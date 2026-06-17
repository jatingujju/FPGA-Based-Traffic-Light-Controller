module traffic_light_controller(
    input clk,
    input rst,

    output reg [2:0] roadA,
    output reg [2:0] roadB
);

localparam A_GREEN  = 2'b00;
localparam A_YELLOW = 2'b01;
localparam B_GREEN  = 2'b10;
localparam B_YELLOW = 2'b11;

reg [1:0] state;
reg [3:0] timer;

// State Register
always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        state <= A_GREEN;
        timer <= 0;
    end
    else
    begin
        timer <= timer + 1;

        case(state)

        A_GREEN:
            if(timer == 4)
            begin
                state <= A_YELLOW;
                timer <= 0;
            end

        A_YELLOW:
            if(timer == 2)
            begin
                state <= B_GREEN;
                timer <= 0;
            end

        B_GREEN:
            if(timer == 4)
            begin
                state <= B_YELLOW;
                timer <= 0;
            end

        B_YELLOW:
            if(timer == 2)
            begin
                state <= A_GREEN;
                timer <= 0;
            end

        endcase
    end
end

// Output Logic
always @(*)
begin
    case(state)

    A_GREEN:
    begin
        roadA = 3'b001;
        roadB = 3'b100;
    end

    A_YELLOW:
    begin
        roadA = 3'b010;
        roadB = 3'b100;
    end

    B_GREEN:
    begin
        roadA = 3'b100;
        roadB = 3'b001;
    end

    B_YELLOW:
    begin
        roadA = 3'b100;
        roadB = 3'b010;
    end

    default:
    begin
        roadA = 3'b100;
        roadB = 3'b100;
    end

    endcase
end

endmodule