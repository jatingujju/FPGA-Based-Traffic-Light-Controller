module traffic_light_controller_v2(
    input clk,
    input rst,

    input ped_req,
    input emergency,
    input night_mode,

    output reg [2:0] roadA,
    output reg [2:0] roadB,
    output reg ped_walk
);

localparam A_GREEN       = 4'd0;
localparam A_YELLOW      = 4'd1;
localparam ALL_RED_1     = 4'd2;
localparam B_GREEN       = 4'd3;
localparam B_YELLOW      = 4'd4;
localparam ALL_RED_2     = 4'd5;
localparam PED_WALK_S    = 4'd6;
localparam EMERG_RED     = 4'd7;
localparam NIGHT_FLASH   = 4'd8;

reg [3:0] state;
reg [7:0] timer;
reg ped_pending;

//====================================================
// State Machine
//====================================================

always @(posedge clk or posedge rst)
begin
    if (rst)
    begin
        state <= A_GREEN;
        timer <= 0;
        ped_pending <= 0;
    end
    else
    begin
        timer <= timer + 1'b1;

        if (ped_req)
            ped_pending <= 1'b1;

        if (emergency)
        begin
            state <= EMERG_RED;
            timer <= 0;
        end
        else if (night_mode)
        begin
            state <= NIGHT_FLASH;
            timer <= 0;
        end
        else
        begin
            case (state)

                A_GREEN:
                begin
                    if (timer >= 12)
                    begin
                        state <= A_YELLOW;
                        timer <= 0;
                    end
                end

                A_YELLOW:
                begin
                    if (timer >= 3)
                    begin
                        state <= ALL_RED_1;
                        timer <= 0;
                    end
                end

                ALL_RED_1:
                begin
                    if (timer >= 1)
                    begin
                        if (ped_pending)
                            state <= PED_WALK_S;
                        else
                            state <= B_GREEN;

                        timer <= 0;
                    end
                end

                B_GREEN:
                begin
                    if (timer >= 12)
                    begin
                        state <= B_YELLOW;
                        timer <= 0;
                    end
                end

                B_YELLOW:
                begin
                    if (timer >= 3)
                    begin
                        state <= ALL_RED_2;
                        timer <= 0;
                    end
                end

                ALL_RED_2:
                begin
                    if (timer >= 1)
                    begin
                        state <= A_GREEN;
                        timer <= 0;
                    end
                end

                PED_WALK_S:
                begin
                    if (timer >= 8)
                    begin
                        state <= B_GREEN;
                        timer <= 0;
                        ped_pending <= 1'b0;
                    end
                end

                EMERG_RED:
                begin
                    if (!emergency)
                    begin
                        state <= A_GREEN;
                        timer <= 0;
                    end
                end

                NIGHT_FLASH:
                begin
                    if (!night_mode)
                    begin
                        state <= A_GREEN;
                        timer <= 0;
                    end
                end

                default:
                begin
                    state <= A_GREEN;
                    timer <= 0;
                end

            endcase
        end
    end
end

//====================================================
// Output Logic
//====================================================

always @(*)
begin
    roadA = 3'b100;
    roadB = 3'b100;
    ped_walk = 1'b0;

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

        ALL_RED_1:
        begin
            roadA = 3'b100;
            roadB = 3'b100;
        end

        ALL_RED_2:
        begin
            roadA = 3'b100;
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

        PED_WALK_S:
        begin
            roadA = 3'b100;
            roadB = 3'b100;
            ped_walk = 1'b1;
        end

        EMERG_RED:
        begin
            roadA = 3'b100;
            roadB = 3'b100;
        end

        NIGHT_FLASH:
        begin
            roadA = 3'b010;
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